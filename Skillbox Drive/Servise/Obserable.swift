//
//  Obserable.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import Foundation

class Box<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T?) {
        self.value = value
    }
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
