//
//  Dictionary+DisplayArranger.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

extension Dictionary {
    subscript<A>(_ key: Key) -> A? {
        get {
            return self[key] as? A
        }
        set {
            self[key] = newValue as? Value
        }
    }
}
