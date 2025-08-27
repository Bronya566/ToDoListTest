//
//  Router.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 25.08.2025.
//
import Foundation
import UIKit

protocol RouterProtocol: AnyObject {
    func goToTaskScreen(model: TaskModelCellData)
    func newTaskScreen()
}

final class Router: RouterProtocol {
    
    weak var controller: MainViewControllerProtocol?
    func goToTaskScreen(model: TaskModelCellData) {
        guard let controller = controller as? UIViewController else { return }
        controller.navigationController?.pushViewController(TaskViewController(model: model), animated: true)
    }
    
    func newTaskScreen() {
        guard let controller = controller as? UIViewController else { return }
        controller.navigationController?.pushViewController(NewTaskViewController(), animated: true)
    }
}
