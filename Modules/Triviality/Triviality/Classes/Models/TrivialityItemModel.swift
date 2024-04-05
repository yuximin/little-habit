//
//  TrivialityItemModel.swift
//  Triviality
//
//  Created by apple on 2024/4/4.
//

import Foundation

struct TrivialityItemModel {
    let id: String
    var icon: String
    var title: String
    var description: String
    let createTime: TimeInterval
    var lastUpdateTime: TimeInterval
    var lastRecodeTime: TimeInterval
    
    init() {
        let now = Date().timeIntervalSince1970
        self.id = "\(now)"
        self.icon = ""
        self.title = ""
        self.description = ""
        self.createTime = now
        self.lastUpdateTime = now
        self.lastRecodeTime = 0
    }
}
