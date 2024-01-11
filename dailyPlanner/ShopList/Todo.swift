//
//  Todo.swift
//  dailyPlanner
//
//  Created by 123 on 10.01.2024.
//

class Todo: Codable, Equatable {
    var name: String
    var isCompleted: Bool

    init(name: String, isCompleted: Bool) {
        self.name = name
        self.isCompleted = isCompleted
    }

    static func == (lhs: Todo, rhs: Todo) -> Bool {
        return lhs.name == rhs.name && lhs.isCompleted == rhs.isCompleted
    }
}
