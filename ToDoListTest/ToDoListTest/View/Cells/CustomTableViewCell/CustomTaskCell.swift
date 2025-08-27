//
//  CustomTaskCell.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 25.08.2025.
//

import UIKit

final class CustomTaskCell: UITableViewCell {
    var model: ModelProtocol?
    private let sizeTextCell: CGFloat = 34
    
    private lazy var mainTitleTask: UITextView = {
        let mainTitle = UITextView()
        mainTitle.textColor = .white
        mainTitle.backgroundColor = .clear
        mainTitle.isScrollEnabled = false
        mainTitle.textContainerInset = .zero
        mainTitle.textContainer.lineFragmentPadding = 0
        mainTitle.font = UIFont(name: "sfProText-Medium", size: sizeTextCell)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        return mainTitle
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = Constants.cellGrayTextColor
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private lazy var subtitleTask: UITextView = {
        let subtitleLabel = UITextView()
        subtitleLabel.textColor = .white
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.isScrollEnabled = false
        subtitleLabel.textContainerInset = .zero
        subtitleLabel.textContainer.lineFragmentPadding = 0
        subtitleLabel.font = UIFont(name: "sfProText-Medium", size: 22)
        //  subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: .none)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(model: TaskModelCellData) {
        mainTitleTask.text = model.title
        subtitleTask.text = model.subtitle
        dateLabel.text = model.date
    }
    
    func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(mainTitleTask)
        contentView.addSubview(subtitleTask)
        contentView.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainTitleTask.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainTitleTask.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainTitleTask.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            dateLabel.topAnchor.constraint(equalTo: mainTitleTask.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: mainTitleTask.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: mainTitleTask.trailingAnchor),
            
            subtitleTask.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            subtitleTask.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            subtitleTask.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
        ])
    }
}

extension CustomTaskCell: TableViewItemServiceable {
    
    var id: String { "CellTask" }
    
    func updateModel(_ model: ModelProtocol?) {
        guard let model = model as? TaskModelCellData else { return }
        setupData(model: model)
    }
}
