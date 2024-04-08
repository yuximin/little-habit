//
//  Mediator_Habit.swift
//  Mediator-Habit
//
//  Created by apple on 2024/4/8.
//

import Foundation
import Mediator

// MARK: - Controllers

extension Habit where Base: Mediator {
    
    public func habitViewController() -> UIViewController {
        guard let viewController = base.performTarget("Habit", action: "HabitViewController", params: [:]) as? UIViewController else {
            fatalError("未实现 HabitViewController")
        }
        return viewController
    }
}

// MARK: - Properties

extension Habit where Base: Mediator {
    
}

// MARK: - Methods

extension Habit where Base: Mediator {
    
}
