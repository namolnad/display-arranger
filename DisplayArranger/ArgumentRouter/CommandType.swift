//
//  CommandType.swift
//  display-arranger
//
//  Created by Dan Loman on 1/16/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

enum CommandType {
    case displaysInfo
    case help
    case ids
    case moveMouse
    case op
    case otherPosition
    case setMain
    case supportedPositions
}

extension CommandType {
    init?(rawValue: String) {
        switch rawValue {
        case "-i", "-info":
            self = .displaysInfo
            return
        case "-h", "-help":
            self = .help
            return
        case "-ids":
            self = .ids
            return
        case "-moveMouse":
            self = .moveMouse
            return
        case "-op", "-otherPosition":
            self = .otherPosition
            return
        case "-setMain":
            self = .setMain
            return
        case "-supportedPositions":
            self = .supportedPositions
            return
        default:
            return nil
        }
    }
}

