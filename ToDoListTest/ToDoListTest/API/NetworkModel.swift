//
//  NetworkModel.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 25.08.2025.
//

struct NetworkModel: Decodable {
    var todos: [ToDoModel]
}

struct ToDoModel: Decodable {
    var id: Int64
    var todo: String
    var completed: Bool
    var date: String?
    var subtitle: String?
}
