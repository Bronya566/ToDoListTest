//
//  Assembly.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 25.08.2025.
//

import Foundation
import UIKit

final class Assembly {
    
    static func build() -> UIViewController {
        let interactor = InteractorTable()
        let router = Router()
        let presenter = PresenterTable(interactor: interactor, router: router)
        let viewController = MainViewController(presenter: presenter)
        
        presenter.mainViewController = viewController
        router.controller = viewController
        interactor.presenter = presenter
        return viewController
    }
}
