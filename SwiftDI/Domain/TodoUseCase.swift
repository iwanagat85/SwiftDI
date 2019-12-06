//
//  TodoUseCase.swift
//  SwiftDI
//
//  Created by iwanagat85 on 2019/09/20.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import Foundation
import RxSwift

public protocol TodoUseCase {
    func fetchAll() -> Single<[TodoItemModel]>
    func add(text: String?) -> Single<TodoItemModel>
    func delete(_ todo: TodoItemModel) -> Single<Void>
}

public class TodoUseCaseImpl: TodoUseCase {

    let repository: TodoItemRepository

    init(repository: TodoItemRepository) {
        self.repository = repository
    }

    public func fetchAll() -> Single<[TodoItemModel]> {
        return repository.fetchAll()
                .map { entity -> TodoItemModel in
                    TodoItemModel(id: entity.id, text: entity.text)
                }
                .toArray()
    }

    public func add(text: String?) -> Single<TodoItemModel> {
        guard let text = text else {
            return Single.error(AppError.EmptyString)
        }
        return repository.add(TodoItemEntity(text: text))
                .map { entity -> TodoItemModel in
                    TodoItemModel(id: entity.id, text: entity.text)
                }
                .asSingle()
    }

    public func delete(_ todo: TodoItemModel) -> Single<Void> {
        return repository.deleteById(todo.id)
                .asSingle()
    }
}
