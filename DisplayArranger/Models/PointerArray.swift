//
//  PointerArray.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

final class PointerArray<A> {
    let capacity: Int

    private let value: UnsafeMutableBufferPointer<A>

    var first: UnsafeMutablePointer<A>

    var array: [A] {
        return Array(value)
    }

    init(capacity: Int) {
        self.capacity = capacity
        self.first = .allocate(capacity: capacity)
        self.value = .init(start: first, count: capacity)
    }

    convenience init(capacity: UInt32) {
        self.init(capacity: Int(capacity))
    }

    deinit {
        first.deallocate(capacity: capacity)
    }

    subscript(_ index: Int) -> A {
        return value[index]
    }
}
