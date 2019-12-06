//
//  TodoItemRepository.swift
//  SwiftDI
//
//  Created by iwanagat85 on 2019/09/20.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import Foundation
import RxSwift

protocol TodoItemRepository {
    func fetchAll() -> Observable<TodoItemModel>
    func add(_ todo: TodoItemEntity) -> Observable<TodoItemModel>
    func deleteById(_ id: Int) -> Observable<Void>
}

public class TodoItemRepositoryImpl: TodoItemRepository {

    let dataSource: TodoItemDataSource

    init(dataSource: TodoItemDataSource) {
        self.dataSource = dataSource
    }

    func fetchAll() -> Observable<TodoItemModel> {
        return dataSource.fetchAll()
                .map { entity -> TodoItemModel in
                    TodoItemModel(id: entity.id, text: entity.text)
                }
    }

    func add(_ todo: TodoItemEntity) -> Observable<TodoItemModel> {
        return dataSource.add(todo)
                .map { entity -> TodoItemModel in
                    TodoItemModel(id: entity.id, text: entity.text)
                }
    }

    func deleteById(_ id: Int) -> Observable<Void> {
        return dataSource.deleteById(id)
    }
}
