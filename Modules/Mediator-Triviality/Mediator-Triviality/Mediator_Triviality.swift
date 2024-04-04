//
//  Mediator_Triviality.swift
//  Mediator-Triviality
//
//  Created by apple on 2024/4/2.
//

import UIKit
import Mediator

// MARK: - Controllers

extension Triviality where Base: Mediator {
    
    public func trivialityViewController() -> UIViewController {
        guard let viewController = base.performTarget("Triviality", action: "TrivialityViewController", params: [:]) as? UIViewController else {
            fatalError("未实现 TrivialityViewController")
        }
        return viewController
    }
}

// MARK: - Properties

extension Triviality where Base: Mediator {
    
}

// MARK: - Methods

extension Triviality where Base: Mediator {
    
}
