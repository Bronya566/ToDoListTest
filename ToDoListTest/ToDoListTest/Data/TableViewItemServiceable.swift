//
//  TableViewItemServiceable.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 25.08.2025.
//
import UIKit

protocol TableViewItemServiceable: UITableViewCell {
    var id: String { get }
    var model: ModelProtocol? { get set }
    func updateModel(_ model: ModelProtocol?)
}

protocol ModelProtocol {}
