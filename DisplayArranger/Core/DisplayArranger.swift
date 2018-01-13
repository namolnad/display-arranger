//
//  DisplayArranger.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

final class DisplayArranger {

    func output(item: OutputItem) {
        let output: String

        do {
            switch item {
            case .help:
                output = help()
            case .undefined:
                output = undefined()
            case .displaysInfo:
                output = displaysInfo().reduce("\n") { $0 + "\($1.description)\n" }
            case .screenIds:
                output = try activeDisplayIds().reduce("\n") { $0 + "\($1)\n" }
            }
        } catch {
            output = error.localizedDescription
        }

        print(output)
    }

    func moveCursor(to: CGPoint, onScreen id: DisplayId) {
        if case let status = CGDisplayMoveCursorToPoint(id, to), status != .success {
            print("Error: \(status.rawValue)")
        }
    }
}
