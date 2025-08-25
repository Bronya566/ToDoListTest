//
//  CustomTableViewCell.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 23.08.2025.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    var model: ModelProtocol?
    
    private var isChecked: Bool = false
    private let sizeTextCell: CGFloat = 12
    
    private var checkImageView: UIImageView = {
        let checkImage = UIImage()
        let checkView = UIImageView(image: checkImage)
        checkView.translatesAutoresizingMaskIntoConstraints = false
        return checkView
    }()
    
    private lazy var mainTitleLabel: UILabel = {
        let mainTitle = UILabel()
        mainTitle.textColor = Constants.cellGrayTextColor
        mainTitle.font = UIFont(name: "sfProText", size: sizeTextCell)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        return mainTitle
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = Constants.cellGrayTextColor
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.textColor = Constants.cellGrayTextColor
        subtitleLabel.numberOfLines = 2
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: .none)
        setupUI()
        setupConstraints()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(model: TaskModelCellData) {
        mainTitleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        dateLabel.text = model.date
        isChecked = model.isChecked
        updateStatus()
    }
}

extension CustomTableViewCell: TableViewItemServiceable {
    
    var id: String { "Cell" }
    
    func updateModel(_ model: ModelProtocol?) {
        guard let model = model as? TaskModelCellData else { return }
        setupData(model: model)
    }
}

private extension CustomTableViewCell {
    func updateStatus() {
        guard isChecked else {
            checkImageView.image = UIImage(named: "checkOff")
            mainTitleLabel.textColor  = .white
            subtitleLabel.textColor = .white
            mainTitleLabel.attributedText = NSAttributedString(string: mainTitleLabel.text ?? "", attributes: [NSAttributedString.Key.strikethroughStyle: 0])
            return
        }
        checkImageView.image = UIImage(named: "checkOn")
        mainTitleLabel.textColor  = Constants.cellGrayTextColor
        subtitleLabel.textColor = Constants.cellGrayTextColor
        mainTitleLabel.attributedText = NSAttributedString(string: mainTitleLabel.text ?? "", attributes: [NSAttributedString.Key.strikethroughStyle: 1])
    }
    
    func setupUI() {
        backgroundColor = .black
        contentView.addSubview(checkImageView)
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            checkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            checkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            checkImageView.heightAnchor.constraint(equalToConstant: 24),
            checkImageView.widthAnchor.constraint(equalToConstant: 24),
            
            mainTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainTitleLabel.leadingAnchor.constraint(equalTo: checkImageView.trailingAnchor, constant: 10),
            mainTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            subtitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 7),
            subtitleLabel.leadingAnchor.constraint(equalTo: mainTitleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: mainTitleLabel.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func setupGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(gestureRecognizer)
    }
}

private extension CustomTableViewCell {
    @objc func tap() {
        isChecked.toggle()
        updateStatus()
    }
}
