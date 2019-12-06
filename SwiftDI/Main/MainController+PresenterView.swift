//
//  MainController+PresenterView.swift
//  SwiftDI
//
//  Created by iwanagat85 on 2019/09/20.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import RxCocoa
import RxSwift

extension MainViewController: MainPresenterView {

    func inject(presenter: MainPresenter) {
        self.presenter = presenter
        self.presenter?.initialize()
    }

    func renderTodoItems(todoItems: [TodoItemModel]) {
        self.todoItems = todoItems
        tableView.reloadData()
    }
    
    func appendTodoItem(_ todo: TodoItemModel) {
        todoItems.append(todo)
        let index = todoItems.count - 1
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    func showAddTodoItemDialog() {
        print("showAddTodoItemDialog")
        let alert = UIAlertController(title: "Add todo item", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Please input text here."
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak alert] (_) in
            guard let self = self else {
                return
            }
            guard let textFields = alert?.textFields, !textFields.isEmpty else {
                return
            }
            self.presenter?.addTodoItem(text: textFields[0].text)
        }))
        present(alert, animated: true, completion: nil)
    }
}


