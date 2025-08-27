//
//  MainViewController.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 22.08.2025.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func updateItems(cells: [TableViewItemServiceable])
    func updateCounts(counts: Int)
    func updateCountTaskView(action: (() -> Void)?)
}

final class MainViewController: UIViewController, MainViewControllerProtocol {
    
    private let tableView = MainTableView()
    private let countTaskView = CountTaskView()
    private let presenter: PresenterProtocol
    
    init(presenter: PresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupNavBar()
        setupTableView()
        setupUI()
        setupConstraints()
    }
    
    func updateItems(cells: [TableViewItemServiceable]) {
        tableView.setItems(items: cells)
    }
    
    func updateCounts(counts: Int) {
        countTaskView.setupCount(taskCount: counts)
    }
    
    func updateCountTaskView(action: (() -> Void)?) {
        countTaskView.actionHandler = action
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .black
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(SearchBarViewCell.self, forCellReuseIdentifier: "SearchBarViewCell")
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
