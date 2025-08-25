//
//  SearchBarViewCell.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 24.08.2025.
//

import UIKit

final class SearchBarViewCell: UITableViewCell {
    
    var model: ModelProtocol?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.backgroundColor = Constants.backgroundTaskView
        searchBar.placeholder = "Search"
        searchBar.barTintColor = .clear
        searchBar.searchTextField.textColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: .none)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchBarViewCell: TableViewItemServiceable {
    
    var id: String { "SearchBarViewCell" }
    
    func updateModel(_ model: (any ModelProtocol)?) {}
}

private extension SearchBarViewCell {
    func setupUI() {
        backgroundColor = .black
        contentView.addSubview(searchBar)
        setupPlaceholderColor(Constants.searchTextColor)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            searchBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func setupPlaceholderColor(_ color: UIColor) {
        guard let searchTextField: UITextField = searchBar.value(forKey: "searchField") as? UITextField,
              searchTextField.responds(to: #selector(getter: UITextField.attributedPlaceholder)) else { return }
        let attributeDict = [NSAttributedString.Key.foregroundColor: color]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributeDict)
        let iconView = searchTextField.leftView as? UIImageView
        iconView?.tintColor = color
    }
}
