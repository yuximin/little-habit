//
//  Mediator.swift
//  Mediator_Example
//
//  Created by Responser on 2022/4/7.
//  Copyright © 2022 3commas. All rights reserved.
//

import Foundation

public class Mediator {

    public static let shared = Mediator()

    public weak var coolie: Coolie?

    public var urlRouteMapConfigure: URLRouteMapConfigure?

    private init() {}

    fileprivate lazy var cachedTarget: [String: NSObject] = [:]

    fileprivate lazy var urlRouteMap: URLRouteMap? = {
        guard let filePath = self.urlRouteMapConfigure?.routeMapFilePath else { return nil }
        return URLRouteMap(filePath: filePath)
    }()
}

extension Mediator {

    /// 远程调用入口
    /// scheme://[user]:[password]@[target]/[action]?[params]
    /// url sample:
    /// "myapp://Limon:123456@targetA/actionB?id=1234&page=2"
    public func performAction(with url: URL) -> NSObject? {

        guard let routeMapConfigure = urlRouteMapConfigure else {
            assert(false, "urlRouteMapConfigure is empty!")
            return nil
        }

        guard let parser = Parser(url: url) else {
            coolie?.mediatorCannotParse(url)
            return nil
        }

        if routeMapConfigure.scheme != parser.scheme {
            coolie?.mediatorCannotMatchScheme(of: url)
            return nil
        }

        guard let urlRouteMap = urlRouteMap, let target = urlRouteMap[parser.target], let action = target.actions[parser.action] else {
            coolie?.mediatorCannotMatch(parser.target, action: parser.action, of: url)
            return nil
        }

        if target.allVerifySkip {
            return performTarget(target.name, action: action.name, params: parser.params)
        }

        if (parser.user != routeMapConfigure.user || parser.password != routeMapConfigure.password) && !action.verifySkip {
            let next = coolie?.mediatorCannotMatch(parser.user, password: parser.password, of: url) ?? false
            if !next {
                return nil
            }
        }

        return performTarget(target.name, action: action.name, params: parser.params)
    }

    /// 本地组件调用入口
    public func performTarget(_ targetName: String, action actionName: String, params: [String: Any], shouldCacheTarget: Bool = false) -> NSObject? {

        let targetClassString = String(format: "Target_%@", targetName)

        let target = cachedTarget[targetClassString] ?? (NSClassFromString(targetClassString) as? NSObject.Type)?.init()

        guard let unwrappedTarget = target else {
            coolie?.mediatorNotFound(targetName)
            return nil
        }

        if shouldCacheTarget {
            self.cachedTarget[targetClassString] = unwrappedTarget
        }

        let actionString = String(format: "Action_%@", actionName)
        let action = Selector(actionString)

        let perform: () -> NSObject? = { [weak self] in

            var result: AnyObject?

            if unwrappedTarget.responds(to: action) {
                result = unwrappedTarget.perform(action, with: params)?.takeUnretainedValue()
            } else {
                let actionString = String(format: "Action_%@WithParams:", actionName)
                let action = Selector(actionString)

                if unwrappedTarget.responds(to: action) {
                    result = unwrappedTarget.perform(action, with: params)?.takeUnretainedValue()
                } else {
                    // 处理无响应请求，尝试调用对应 target 的 NotFound 方法统一处理
                    let action = Selector(("Action_NotFoundWithParams:"))
                    if unwrappedTarget.responds(to: action) {
                        result = unwrappedTarget.perform(action, with: params)?.takeUnretainedValue()
                    } else {
                        // 对应的 target 也无实现 NotFound 方法
                        self?.coolie?.mediatorNotFound(actionName, of: unwrappedTarget)
                        _ = self?.cachedTarget.removeValue(forKey: targetClassString)
                    }
                }
            }

            return result as? NSObject
        }

        // Before Action
        let shouldLoginBeforeAction = Selector(("BeforeAction_ShouldLoginWithActionName:"))
        if unwrappedTarget.responds(to: shouldLoginBeforeAction) {
            // 询问 target 需不需要登录，但还需要判断现在的登录状态，登录状态判断放在登录模块，这样其它模块不需要知道登录状态
            if let shouldLogin = (unwrappedTarget.perform(shouldLoginBeforeAction, with: actionName)?.takeUnretainedValue() as? [String: Any])?["result"] as? Bool, shouldLogin {
                let successHandler: () -> Void = {
                    _ = perform()
                }
                coolie?.mediatorRequestPermission(with: successHandler)
                return nil
            }
        }
        
        return perform()
    }
}

extension Mediator {
    public func releaseCachedTarget(with targetName: String) {
        let targetClassString = String(format: "Target_%@", targetName)
        cachedTarget.removeValue(forKey: targetClassString)
    }
}
