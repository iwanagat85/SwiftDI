//
//  RealmObject.swift
//  SwiftDI
//
// Created by iwanagat80 on 2019/09/25.
// Copyright (c) 2019 iwanagat85. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmObject: RealmSwift.Object {

    @objc dynamic var id = 0

    public override class func primaryKey() -> String? {
        return "id"
    }
}

extension Realm {
    public func newId<T: RealmObject>(_ type: T.Type) -> Int {
        if let last = self.objects(type).sorted(byKeyPath: "id").last {
            return last.id + 1
        } else {
            return 1
        }
    }
}