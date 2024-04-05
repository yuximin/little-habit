//
//  TrivialityEditorViewModel.swift
//  Triviality
//
//  Created by apple on 2024/4/5.
//

import Foundation

class TrivialityEditorViewModel {
    
    typealias Completion = (_ success: Bool, _ error: TrivialityEditorError?, _ trivialityItem: TrivialityItemModel?) -> Void
    
    typealias CheckValidityResult = (validity: Bool, error: TrivialityEditorError?)
    
    private let editorType: TrivialityEditorType
    
    let editorItems: [TrivialityEditorItem] = [.icon, .title, .description]
    
    private var trivialityItem: TrivialityItemModel?
    
    init(editorType: TrivialityEditorType) {
        self.editorType = editorType
        self.trivialityItem = editorType.trivialityItem
    }
    
    func executeSave(editorItemValues: [TrivialityEditorItem: Any?], completion: @escaping Completion) {
        let checkResult = self.checkValidity(editorItemValues: editorItemValues)
        guard checkResult.validity else {
            completion(false, checkResult.error, nil)
            return
        }
        
        let trivialityItem = self.createNewTrivialityItem(editorItemValues: editorItemValues)
        completion(true, nil, trivialityItem)
    }
    
    private func checkValidity(editorItemValues: [TrivialityEditorItem: Any?]) -> CheckValidityResult {
        for editorItem in self.editorItems {
            if let value = editorItemValues[editorItem],
               editorItem.checkValueValidity(value: value) {
                continue
            }
            
            let error: TrivialityEditorError
            switch editorItem {
            case .icon:
                error = .invaildIcon
            case .title:
                error = .invaildTitle
            case .description:
                error = .invaildDescription
            }
            return (validity: false, error: error)
        }
        
        return (validity: true, error: nil)
    }
    
    private func createNewTrivialityItem(editorItemValues: [TrivialityEditorItem: Any?]) -> TrivialityItemModel {
        var trivialityItem: TrivialityItemModel
        switch editorType {
        case .create:
            trivialityItem = TrivialityItemModel()
        case .modify(let model):
            trivialityItem = model
            trivialityItem.lastUpdateTime = Date().timeIntervalSince1970
        }
        
        for editorItem in self.editorItems {
            let value = editorItemValues[editorItem]
            switch editorItem {
            case .icon:
                trivialityItem.icon = value as? String ?? ""
            case .title:
                trivialityItem.title = value as? String ?? ""
            case .description:
                trivialityItem.description = value as? String ?? ""
            }
        }
        return trivialityItem
    }
}
