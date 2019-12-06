//
//  DiProvider.swift
//  SwiftDI
//
//  Created by iwanagat80 on 2019/12/06.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import Foundation

public protocol DiProvider {
}

class DiContainer {

    public static var shared = DiContainer()

    private var container: NSMapTable<NSString, AnyObject>

    private init() {
        container = NSMapTable.weakToWeakObjects()
    }

    func provide<T>(_ alias: String? = nil, _ selector: () -> T) -> T {
        let key = (alias ?? String(describing: T.self)) as NSString
        if let sharedInstance = container.object(forKey: key) as? T {
            return sharedInstance
        } else {
            let instance: T = selector()
            container.setObject(instance as AnyObject, forKey: key)
            return instance
        }
    }
}

extension DiProvider {
    static var container: DiContainer {
        get {
            return DiContainer.shared
        }
    }
}
