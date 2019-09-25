//
//  Presenter.swift
//  SwiftDI
//
//  Created by iwanagat85 on 2019/09/20.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import Foundation
import UIKit

public protocol Presenter: class {
    func initialize()
    func prepare(for segue: UIStoryboardSegue)
    func unwind(for unwindSegue: UIStoryboardSegue)
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol PresenterView: class {
}

extension PresenterView where Self: UIViewController {
}
