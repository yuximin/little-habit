//
//  TrivialityEditorType.swift
//  Triviality
//
//  Created by apple on 2024/4/5.
//

import Foundation

enum TrivialityEditorType {
    case create
    case modify(model: TrivialityItemModel)
    
    var trivialityItem: TrivialityItemModel? {
        switch self {
        case .create:
            return nil
        case .modify(let model):
            return model
        }
    }
}

enum TrivialityEditorItem {
    case icon
    case title
    case description
    
    var cellHeight: CGFloat {
        switch self {
        case .icon:
            return 100
        case .title:
            return 80
        case .description:
            return 80
        }
    }
    
    func checkValueValidity(value: Any?) -> Bool {
        switch self {
        case .icon, .title, .description:
            if let realValue = value as? String,
               !realValue.isEmpty {
                return true
            }
            return false
        }
    }
}

struct TrivialityEditorValueModel {
    let type: TrivialityEditorItem
    let value: Any?
    
    init(type: TrivialityEditorItem, value: Any?) {
        self.type = type
        self.value = value
    }
}
