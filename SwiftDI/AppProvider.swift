//
//  AppProvider.swift
//  SwiftDI
//
//  Created by iwanagat85 on 2019/09/20.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import Foundation
import UIKit

protocol AppProvider {
}

// Presenter
extension AppProvider {
    static func provide(_ controller: MainViewController) -> MainPresenter {
        let presenter = MainPresenterImpl(useCase: provide())
        presenter.view = controller
        return presenter
    }
}

// Domain
extension AppProvider {
    static func provide() -> TodoUseCase {
        return TodoUseCaseImpl(repository: provide())
    }
}

// Data
extension AppProvider {
    static func provide() -> TodoItemRepository {
        return TodoItemRepositoryImpl(dataSource: provide())
    }

    static func provide() -> TodoItemDataSource {
        return TodoItemDataSourceImpl()
    }
}
