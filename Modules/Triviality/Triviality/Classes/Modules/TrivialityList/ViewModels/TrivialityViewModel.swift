//
//  TrivialityViewModel.swift
//  Triviality
//
//  Created by apple on 2024/4/4.
//

import Foundation

class TrivialityViewModel {
    private(set) var items: [TrivialityItemModel] = []
    
    func addItem(_ item: TrivialityItemModel) {
        self.items.append(item)
    }
}
