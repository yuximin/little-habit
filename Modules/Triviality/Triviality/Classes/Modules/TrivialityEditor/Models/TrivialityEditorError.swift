//
//  TrivialityEditorError.swift
//  Triviality
//
//  Created by apple on 2024/4/5.
//

import Foundation

enum TrivialityEditorError {
    case invaildIcon
    case invaildTitle
    case invaildDescription
}

extension TrivialityEditorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invaildIcon:
            return "无效图标"
        case .invaildTitle:
            return "无效标题"
        case .invaildDescription:
            return "无效描述"
        }
    }
}
