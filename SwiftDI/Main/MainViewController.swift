//
//  ViewController.swift
//  SwiftDI
//
//  Created by iwanagat85 on 2019/09/20.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UITableViewController {

    var todoItems = [TodoItemModel]()

    var presenter: MainPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        AppInjector.inject(self)
        tableView.tableFooterView = UIView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        presenter?.prepare(for: segue)
    }

    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        super.unwind(for: unwindSegue, towards: subsequentVC)
        presenter?.unwind(for: unwindSegue)
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        presenter?.viewWillDisappear()
    }

    @IBAction func didAddTodoItemButtonTapped(_ sender: Any) {
        presenter?.didAddTodoItemButtonTapped()
    }
}

extension MainViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todo Cell", for: indexPath) as! TodoTableViewCell
        cell.titleLabel.text = todoItems[indexPath.row].text
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            presenter?.delete(todoItems[indexPath.row])
            todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}
