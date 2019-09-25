//
//  MainPresenter.swift
//  SwiftDI
//
//  Created by iwanagat85 on 2019/09/20.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

public protocol MainPresenterView: PresenterView {
    func renderTodoItems(todoItems: [TodoItemModel])
    func appendTodoItem(_ todo: TodoItemModel)
    func showAddTodoItemDialog()
}

public protocol MainPresenter: Presenter {
    func didAddTodoItemButtonTapped()
    func addTodoItem(text: String?)
    func delete(_ todo: TodoItemModel)
}

public class MainPresenterImpl: MainPresenter {

    var view: MainPresenterView?

    private var disposeBag: DisposeBag! = DisposeBag()

    private let useCase: TodoUseCase

    init(useCase: TodoUseCase) {
        self.useCase = useCase
    }

    public func initialize() {
        useCase.fetchAll()
                .subscribe(onSuccess: { [weak self] (response) in
                    guard let self = self else {
                        return
                    }
                    self.view?.renderTodoItems(todoItems: response)
                }, onError: { (error) in
                    assert(true, "not implemented")
                })
                .disposed(by: disposeBag)
    }

    public func didAddTodoItemButtonTapped() {
        view?.showAddTodoItemDialog()
    }

    public func addTodoItem(text: String?) {
        guard let text = text, text != "" else {
            return
        }
        useCase.add(text: text)
                .subscribe(onSuccess: { [weak self] (todo) in
                    guard let self = self else {
                        return
                    }
                    self.view?.appendTodoItem(todo)
                }, onError: { (error) in
                    assert(true, "not implemented")
                })
                .disposed(by: disposeBag)
    }

    public func delete(_ todo: TodoItemModel) {
        useCase.delete(todo)
                .subscribe(onSuccess: { [weak self] (response) in
                    guard self != nil else {
                        return
                    }
                }, onError: { (error) in
                    assert(true, "not implemented")
                })
                .disposed(by: disposeBag)
    }

    public func prepare(for segue: UIStoryboardSegue) {
    }

    public func unwind(for unwindSegue: UIStoryboardSegue) {
    }

    public func viewWillAppear() {
    }

    public func viewWillDisappear() {
        disposeBag = nil
    }
}
