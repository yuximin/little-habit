//
//  Hall.swift
//  Mediator-Hall
//
//  Created by apple on 2024/4/2.
//

import Foundation
import Mediator

public struct Hall<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol HallProtocol {}

extension Mediator: HallProtocol {}

extension HallProtocol {
    public var hall: Hall<Self> {
        return Hall(self)
    }

    public static var hall: Hall<Self>.Type {
        return Hall.self
    }
}
