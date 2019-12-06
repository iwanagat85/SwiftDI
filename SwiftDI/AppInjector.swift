//
//  AppInjector.swift
//  SwiftDI
//
//  Created by iwanagat85 on 2019/09/20.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import Foundation

public class AppInjector:
        MainViewInjector {
}

protocol MainViewInjector: AppProvider {
    static func inject(_ controller: MainViewController)
}

extension MainViewInjector {
    static func inject(_ controller: MainViewController) {
        controller.inject(presenter: provide(controller))
    }
}
