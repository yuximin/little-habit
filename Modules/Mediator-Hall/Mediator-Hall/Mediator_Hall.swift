//
//  Mediator_Hall.swift
//  Mediator-Hall
//
//  Created by apple on 2024/4/2.
//

import UIKit
import Mediator

// MARK: - Controllers

extension Hall where Base: Mediator {
    
    public func hallTabBarController() -> UITabBarController {
        guard let tabBarController = base.performTarget("Hall", action: "HallTabBarController", params: [:]) as? UITabBarController else {
            fatalError("未实现 HallTabBarController")
        }
        return tabBarController
    }
}

// MARK: - Properties

extension Hall where Base: Mediator {
    
}

// MARK: - Methods

extension Hall where Base: Mediator {
    
}
