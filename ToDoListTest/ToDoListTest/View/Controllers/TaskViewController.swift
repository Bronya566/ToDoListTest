//
//  TaskViewController.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 25.08.2025.
//

import UIKit

final class TaskViewController: UIViewController {
    
    private let tableView = MainTableView()
    private let model: TaskModelCellData
    
    init(model: TaskModelCellData) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .yellow
        setupUI()
        setupConstraints()
        setupTaskTableView()
        updateItems()
    }
    
    private func updateItems() {
        let cell = CustomTaskCell()
        cell.model = model
        tableView.setItems(items: [cell])
    }
    
    private func setupTaskTableView() {
        tableView.backgroundColor = .black
        tableView.register(CustomTaskCell.self, forCellReuseIdentifier: "CellTask")
    }
    
    private func setupUI() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
