//
//  Numerics+DisplayArranger.swift
//  display-arranger
//
//  Created by Dan Loman on 1/16/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

extension CGPoint {
    init?(_ string: String?) {
        guard let string = string else {
            return nil
        }
        guard case let components = string.components(separatedBy: "-"), components.count == 2 else {
            return nil
        }
        guard let x = CGFloat(components.first), let y = CGFloat(components.last) else {
            return nil
        }

        self.init(x: x, y: y)
    }
}

extension CGFloat {
    init?(_ string: String?) {
        guard let string = string, let doubleValue = Double(string) else {
            return nil
        }

        self.init(doubleValue)
    }
}

extension DisplayId {
    init?(_ string: String?) {
        guard let string = string else {
            return nil
        }

        self.init(string)
    }
}
