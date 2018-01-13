//
//  main.swift
//   display-arranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//
// requires Mac OS X 10.13 or higher

import Foundation

let arranger: DisplayArranger = .init()

// FIXME: - Create argument parser object, w/ safer access of arguments to prevent out of range crashes
switch ProcessInfo().arguments {
case let args where args.count == 1, let args where args[1] == "-h":
    arranger.output(item: .help)
case let args where args[1] == "-info":
    arranger.output(item: .displaysInfo)
case let args where args[1] == "-screenIds":
    arranger.output(item: .screenIds)
case let args where args[1] == "-setMain":
    guard let mainId = UInt32(args[2]) else {
        fatalError("No main id argument")
    }
    guard args.count > 3, args[3] == "-otherPosition" else {
        arranger.setAsMainDisplay(id: mainId)
        break
    }

    do {
        // FIXME: need to figure out parsing for > 2 displays
        guard case let ids = try arranger.activeDisplayIds(context: .adjusting),
            let other = ids.subtracting([mainId]).first else {
            throw DisplayArrangerError.screenPositionParsing
        }

        arranger.setAsMainDisplay(id: mainId, otherPositions: [other: try .init(args[4])])
    } catch {
        if let error = error as? DisplayArrangerError, let desc = error.localizedDescription {
            print(desc)
        } else {
            print(error)
        }
    }
case let args where args[1] == "-moveMouse":
    guard case let position = args[2].components(separatedBy: "-").flatMap(Int.init), position.count == 2 else {
        print("Unable to parse mouse coordinates")
        break
    }
    guard let mainId = arranger.displaysInfo().first?.id else {
        print("Main id unavailable")
        break
    }
    arranger.moveCursor(to: .init(x: position[0], y: position[1]), onScreen: mainId)
default:
    arranger.output(item: .undefined)
}
