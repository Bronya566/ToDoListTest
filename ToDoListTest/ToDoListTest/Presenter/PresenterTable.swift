//
//  PresenterTable.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 25.08.2025.
//

import Foundation

protocol PresenterProtocol: AnyObject {
    func updateItems(result: [ToDoModel])
    func viewDidLoad()
}

final class PresenterTable: PresenterProtocol {
    private let interactor: InteractorProtocol
    private let router: RouterProtocol
    weak var mainViewController: MainViewControllerProtocol?
    
    init(interactor: InteractorProtocol,
         router: RouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func updateItems(result: [ToDoModel]) {
        DispatchQueue.main.async {
            var items: [TableViewItemServiceable] = [SearchBarViewCell()]
            result.forEach { model in
                let item = CustomTableViewCell()
                item.model = TaskModelCellData(title: model.todo, subtitle: "", date: "09/10/24", isChecked: model.completed, actionHandler: { [weak self] in
                    let taskData = TaskModelCellData(title: model.todo, date: "09/10/24", isChecked: model.completed)
                    self?.router.goToTaskScreen(model: taskData)
                }, deleteAction: { [weak self] in
                    self?.interactor.deleteData(id: model.id)
                })
                items.append(item)
            }
            self.mainViewController?.updateItems(cells: items)
            self.mainViewController?.updateCounts(counts: result.count)
        }
    }
    
    func viewDidLoad() {
        interactor.getTableData()
        updateCountTaskView()
    }
    
    private func updateCountTaskView() {
        mainViewController?.updateCountTaskView { [weak self] in
            self?.router.newTaskScreen()
        }
    }
}
