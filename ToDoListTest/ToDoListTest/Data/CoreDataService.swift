//
//  CoreDataService.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 26.08.2025.
//

import CoreData

final class CoreDataService {
    
    static let shared: CoreDataService = {
        let service = CoreDataService()
        return service
    }()
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                print(error)
            }
        })
        return container
    }()
    
    private func save() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func load() -> [TaskData]? {
        let fetchRequest: NSFetchRequest<TaskData> = TaskData.fetchRequest()
        
        guard let dataTask = try? container.viewContext.fetch(fetchRequest) else {
            return nil
        }
        return dataTask
    }
    
    func addTaskData(id: Int64?, date: String?, todo: String?, completed: Bool?) {
        
        let fetchRequest: NSFetchRequest<TaskData> = TaskData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: ["task"])
        guard (try? container.viewContext.fetch(fetchRequest).first) != nil else {
            let taskModel = TaskData(context: container.viewContext)
            taskModel.id = id ?? 0
            taskModel.date = date ?? ""
            taskModel.todo = todo ?? ""
            taskModel.completed = completed ?? false
            save()
            return
        }
        save()
    }
    
    func deleteTask(id: Int64) {
        let fetchRequest: NSFetchRequest<TaskData> = TaskData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        guard let dataTask = try? container.viewContext.fetch(fetchRequest).first else {
            return
        }
        container.viewContext.delete(dataTask)
        save()
    }
}
