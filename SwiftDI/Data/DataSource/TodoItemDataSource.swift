//
//  TodoItemDataSource.swift
//  SwiftDI
//
//  Created by iwanagat85 on 2019/09/20.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

public protocol TodoItemDataSource {
    func fetchAll() -> Observable<TodoItemEntity>
    func add(_ todo: TodoItemEntity) -> Observable<TodoItemEntity>
    func deleteById(_ id: Int) -> Observable<Void>
}

public struct TodoItemDataSourceImpl: TodoItemDataSource {

    private let realm = try! Realm()

    init() {
    }

    public func fetchAll() -> Observable<TodoItemEntity> {
        return Observable<TodoItem>.from(realm.objects(TodoItem.self).sorted(byKeyPath: "id"))
                .map { (element: TodoItem) -> TodoItemEntity in
                    TodoItemEntity(id: element.id, text: element.text)
                }
    }

    public func add(_ todo: TodoItemEntity) -> Observable<TodoItemEntity> {
        do {
            try realm.write {
                realm.add(realm.create(TodoItem.self, value: ["id": realm.newId(TodoItem.self), "text": todo.text]))
            }
            return Observable.just(todo)
        } catch {
            return Observable.error(error)
        }
    }

    public func deleteById(_ id: Int) -> Observable<Void> {
        do {
            try realm.write {
                if let item = realm.objects(TodoItem.self).filter("id=\(id)").first {
                    realm.delete(item)
                }
            }
            return Observable.empty()
        } catch {
            return Observable.error(error)
        }
    }
}
