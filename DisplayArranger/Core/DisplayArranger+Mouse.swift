//
//  DisplayArranger+Mouse.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

final class DisplayArranger {

    func moveCursor(to: CGPoint, onScreen id: DisplayId) {
        if case let status = CGDisplayMoveCursorToPoint(id, to), status != .success {
            print("Error: \(status.rawValue)")
        }
    }
}
