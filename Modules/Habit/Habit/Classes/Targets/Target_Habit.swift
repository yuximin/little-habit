//
//  Target_Habit.swift
//  Habit
//
//  Created by apple on 2024/4/8.
//

import Foundation

@objc(Target_Habit)
class Target_Habit: NSObject {}

// MARK: - Controllers

@objc extension Target_Habit {
    
    func Action_HabitViewController(params: [String: Any]) -> UIViewController? {
        let habitViewController = HabitViewController()
        return habitViewController
    }
}

// MARK: - Properties

@objc extension Target_Habit {

}

// MARK: - Methods

@objc extension Target_Habit {
    
}
