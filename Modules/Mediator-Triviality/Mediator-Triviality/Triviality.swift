//
//  Triviality.swift
//  Mediator-Triviality
//
//  Created by apple on 2024/4/2.
//

import Foundation
import Mediator

public struct Triviality<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol TrivialityProtocol {}

extension Mediator: TrivialityProtocol {}

extension TrivialityProtocol {
    public var triviality: Triviality<Self> {
        return Triviality(self)
    }

    public static var triviality: Triviality<Self>.Type {
        return Triviality.self
    }
}
