//
//  AppProvider.swift
//  SwiftDI
//
//  Created by iwanagat85 on 2019/09/20.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import Foundation

protocol AppProvider: DiProvider {
}

// Presenter
extension AppProvider {
    static func provide(_ controller: MainViewController) -> MainPresenter {
        return container.provide { () -> MainPresenter in
            let presenter = MainPresenterImpl(useCase: provide())
            presenter.view = controller
            return presenter
        }
    }
}

// Domain
extension AppProvider {

    static func provide() -> TodoUseCase {
        return container.provide { () -> TodoUseCase in
            return TodoUseCaseImpl(repository: provide())
        }
    }
}

// Data
extension AppProvider {
    
    static func provide() -> TodoItemRepository {
        return container.provide { () -> TodoItemRepository in
            return TodoItemRepositoryImpl(dataSource: provide())
        }
    }

    static func provide() -> TodoItemDataSource {
        return container.provide { () -> TodoItemDataSource in
            return TodoItemDataSourceImpl()
        }
    }
}
