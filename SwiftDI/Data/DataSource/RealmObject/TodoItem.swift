//
//  TodoItem.swift
//  SwiftDI
//
//  Created by iwanagat85 on 2019/09/20.
//  Copyright © 2019 iwanagat85. All rights reserved.
//

import Foundation
import RealmSwift

public class TodoItem: RealmObject {
    @objc dynamic var text: String = ""
}
