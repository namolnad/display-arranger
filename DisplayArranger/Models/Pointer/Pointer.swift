//
//  Pointer.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/12/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

final class Pointer<A> {
    let pointer: UnsafeMutablePointer<A>

    private let capacity: Int

    init(capacity: Int) {
        self.pointer = .allocate(capacity: capacity)
        self.capacity = capacity
    }

    init(with contents: [A]) {
        self.pointer = .allocate(capacity: contents.count)
        self.capacity = contents.count

        self.pointer.initialize(from: contents, count: contents.count)
    }

    convenience init(capacity: UInt32) {
        self.init(capacity: Int(capacity))
    }

    deinit {
        pointer.deallocate(capacity: capacity)
    }

    subscript(_ key: Int) -> A {
        return pointer[key]
    }
}
