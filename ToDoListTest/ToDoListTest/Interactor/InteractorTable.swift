//
//  InteractorTable.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 25.08.2025.
//
import UIKit

protocol InteractorProtocol {
    func getTableData()
    func deleteData(id: Int64)
}

final class InteractorTable: InteractorProtocol {
    
    weak var presenter: PresenterProtocol?
    private let networkService = NetworkService()
    private var networkModel = [ToDoModel]()
    
    private let dataTask = CoreDataService.shared
    private var modelTaskData: TaskData?
    
    
    func getTableData() {
        let storedTasks = dataTask.load()?.compactMap { model in
            return ToDoModel(id: model.id, todo: model.todo ?? "", completed: model.completed)
        }
        guard storedTasks?.isEmpty == true else {
            presenter?.updateItems(result: storedTasks ?? [])
            return
        }
        getNetworkData()
    }
    
    private func getNetworkData() {
        networkService.getData(){[weak self] result in
            self?.presenter?.updateItems(result: result)
            result.forEach { [weak self] in
                self?.saveData(id: Int64($0.id), date: $0.date, todo: $0.todo, completed: $0.completed)
            }
        }
    }
    
    private func saveData(id: Int64?, date: String?, todo: String?, completed: Bool?) {
        dataTask.addTaskData(id: id, date: date, todo: todo, completed: completed)
    }
    
    func deleteData(id: Int64) {
        dataTask.deleteTask(id: id)
        let storedTasks = dataTask.load()?.compactMap { model in
            return ToDoModel(id: model.id, todo: model.todo ?? "", completed: model.completed)
        }
        presenter?.updateItems(result: storedTasks ?? [])
    }
}
