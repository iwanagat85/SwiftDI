//
//  TodoItemEntity.swift
//  SwiftDI
//
// Created by iwanagat80 on 2019/09/25.
// Copyright (c) 2019 iwanagat85. All rights reserved.
//

import Foundation

public struct TodoItemEntity {
    let id: Int
    let text: String

    public init(id: Int = 0, text: String) {
        self.id = id
        self.text = text
    }
}