//
//  Habit.swift
//  Mediator-Habit
//
//  Created by apple on 2024/4/8.
//

import Foundation
import Mediator

public struct Habit<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol HabitProtocol {}

extension Mediator: HabitProtocol {}

extension HabitProtocol {
    public var habit: Habit<Self> {
        return Habit(self)
    }

    public static var habit: Habit<Self>.Type {
        return Habit.self
    }
}
