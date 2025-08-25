//
//  MainViewController.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 22.08.2025.
//

import UIKit

protocol MainViewControllerProtocol {}

final class MainViewController: UIViewController, MainViewControllerProtocol {
    
    private let tableView = MainTableView()
    private let countTaskView = CountTaskView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        setupUI()
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .black
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(SearchBarViewCell.self, forCellReuseIdentifier: "SearchBarViewCell")
        let item = CustomTableViewCell()
        item.model = TaskModelCellData(title: "Прочитать книгу", subtitle: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.", date: "09/10/24", isChecked: true)
        let searchItem = SearchBarViewCell()
        tableView.setItems(items: [searchItem, item])
    }
    
    private func setupNavBar() {
        navigationItem.title = "Задачи"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(countTaskView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        countTaskView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: countTaskView.topAnchor),
            
            countTaskView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            countTaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countTaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countTaskView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
