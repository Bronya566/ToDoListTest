//
//  MainTableView.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 23.08.2025.
//

import UIKit

final class MainTableView: UITableView {
    
    private var items: [TableViewItemServiceable] = []
    
    init() {
        super.init(frame: .zero, style: .grouped)
        allowsSelection = false
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItems(items: [TableViewItemServiceable]) {
        self.items = items
        reloadData()
    }
}

extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = items[indexPath.row].id
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell()
        guard let cell = cell as? TableViewItemServiceable else { return UITableViewCell()}
        cell.updateModel(items[indexPath.row].model)
        return cell
    }
}
