//
//  Target_Hall.swift
//  Hall
//
//  Created by apple on 2024/4/2.
//

import Foundation

@objc(Target_Hall)
class Target_Hall: NSObject {}

// MARK: - Controllers

@objc extension Target_Hall {
    
    func Action_HallTabBarController(params: [String: Any]) -> UITabBarController? {
        let hallTabBarController = HallTabBarViewController()
        return hallTabBarController
    }
}

// MARK: - Properties

@objc extension Target_Hall {

}

// MARK: - Methods

@objc extension Target_Hall {
    
}
