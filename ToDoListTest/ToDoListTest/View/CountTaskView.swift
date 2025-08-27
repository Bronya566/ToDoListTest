//
//  CountTaskView.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 23.08.2025.
//

import UIKit

final class CountTaskView: UIView {
    
    var actionHandler: (() -> Void)?
    
    private let taskTitle: UILabel = {
        let taskTitle = UILabel()
        taskTitle.textColor = .white
        taskTitle.textAlignment = .center
        return taskTitle
    }()
    
    private let taskCount: UILabel = {
        let taskCount = UILabel()
        taskCount.textAlignment = .right
        taskCount.textColor = .white
        return taskCount
    }()
    
    private lazy var taskButton: UIButton = {
        let taskButton = UIButton()
        taskButton.setImage(UIImage(named: "buttonIcon"), for: .normal)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        taskButton.addGestureRecognizer(gestureRecognizer)
        return taskButton
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Constants.backgroundTaskView
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCount(taskCount: Int) {
        taskTitle.text = "\(String(taskCount)) задач"
    }
}

private extension CountTaskView {
    
    @objc func tap() {
        actionHandler?()
    }
    
    func setupUI() {
        addSubview(taskTitle)
        addSubview(taskButton)
    }
    
    func setupConstraints() {
        taskTitle.translatesAutoresizingMaskIntoConstraints = false
        taskCount.translatesAutoresizingMaskIntoConstraints = false
        taskButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskTitle.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            taskTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            taskTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            taskButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            taskButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            taskButton.widthAnchor.constraint(equalToConstant: 68),
            taskButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
