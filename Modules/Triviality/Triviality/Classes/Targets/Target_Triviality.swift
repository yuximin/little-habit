//
//  Target_Triviality.swift
//  Hall
//
//  Created by apple on 2024/4/2.
//

import Foundation

@objc(Target_Triviality)
class Target_Triviality: NSObject {}

// MARK: - Controllers

@objc extension Target_Triviality {
    
    func Action_TrivialityViewController(params: [String: Any]) -> UIViewController? {
        let viewController = TrivialityViewController()
        return viewController
    }
}

// MARK: - Properties

@objc extension Target_Triviality {

}

// MARK: - Methods

@objc extension Target_Triviality {
    
}
