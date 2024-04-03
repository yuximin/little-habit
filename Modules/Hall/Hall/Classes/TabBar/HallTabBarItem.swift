//
//  HallTabBarItem.swift
//  Hall
//
//  Created by apple on 2024/4/3.
//

import Foundation

enum HallTabBarItem {
    case habit
    case triviality
    case me
}

extension HallTabBarItem {
    var title: String {
        switch self {
        case .habit:
            return "习惯"
        case .triviality:
            return "小事"
        case .me:
            return "我的"
        }
    }
}
