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
    
    func removeItem(_ item: TrivialityItemModel) {
        self.items.removeAll { $0 == item }
    }
    
    func updateItem(_ item: TrivialityItemModel) {
        guard let index = self.items.firstIndex(of: item) else { return }
        
        self.items[index] = item
    }
}
