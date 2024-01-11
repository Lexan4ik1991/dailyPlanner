//
//  Todo.swift
//  dailyPlanner
//
//  Created by 123 on 10.01.2024.
//

import Foundation

class Todo {
    var name: String
    var isCompleted: Bool
    var id: UUID
    
    init(name: String, isCompleted: Bool, id: UUID = UUID()) {
        self.name = name
        self.isCompleted = isCompleted
        self.id = id
    }
}
