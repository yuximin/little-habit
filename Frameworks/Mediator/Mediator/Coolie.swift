//
//  Coolie.swift
//  Mediator_Example
//
//  Created by Responser on 2022/4/7.
//  Copyright © 2022 3commas. All rights reserved.
//

import Foundation

public protocol Coolie: class {

    func mediatorCannotParse(_ url: URL)
    func mediatorCannotMatchScheme(of url: URL)
    func mediatorCannotMatch(_ target: String, action: String, of url: URL)

    /// 无法匹配 User 或 Password
    /// return 是否允许继续执行
    func mediatorCannotMatch(_ user: String, password: String, of url: URL) -> Bool

    func mediatorNotFound(_ target: String)
    func mediatorNotFound(_ action: String, of target: NSObject)

    /// 需要权限才能触发 Target-Action
    func mediatorRequestPermission(with successHandler: @escaping () -> Void)
}

extension Coolie {

    public func mediatorCannotParse(_ url: URL) {}
    public func mediatorCannotMatchScheme(of url: URL) {}
    public func mediatorCannotMatch(_ target: String, action: String, of url: URL) {}
    public func mediatorCannotMatch(_ user: String, password: String, of url: URL) -> Bool { return false }

    public func mediatorNotFound(_ target: String) {}
    public func mediatorNotFound(_ action: String, of target: NSObject) {}

    public func mediatorRequestPermission(with successHandler: @escaping () -> Void) {}
}
