//
//  ArgumentRouter.swift
//  display-arranger
//
//  Created by Dan Loman on 1/14/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

final class ArgumentRouter {

    func route(args: [String], arranger: DisplayArranger) {
        var arguments = args
        // Remove first argument as it is simply the call to display-arranger
        arguments.removeFirst()

        var commands: [Command] = []
        var pendingArguments: [String] = []

        for arg in arguments.reversed() {
            if let command = Command(arguments: [arg] + pendingArguments.reversed()) {
                defer { pendingArguments.removeAll() }

                commands.append(command)
            } else {
                pendingArguments.append(arg)
            }
        }

        if commands.isEmpty {
            commands.append(arguments.isEmpty ? .help : .undefined)
        }

        var pendingPositions: [DisplayId: ScreenPosition] = [:]

        commands.forEach {
            switch $0 {
            case .allowablePositions:
                print(DisplayArranger.TextOutput.allowablePositions)
            case .displaysInfo:
                print(arranger.displaysInfo().reduce("\n") { $0 + "\($1.description)\n" })
            case .help:
                print(DisplayArranger.TextOutput.help)
            case .moveMouse(let point):
                if let id = arranger.displaysInfo().first?.id {
                    arranger.moveCursor(to: point, onScreen: id)
                }
            case .otherPosition(let position, referenceDisplay: _):
                // TODO: - set this up so can pass in the appropriate display id
                // as well as a custom reference display
                if case let displaysInfo = arranger.displaysInfo(), let primary = displaysInfo.first, let secondary = displaysInfo.last, primary.id != secondary.id {
                    pendingPositions[secondary.id] = position
                }
            case .screenIds:
                do {
                    print(try arranger.activeDisplayIds().reduce("\n") { $0 + "\($1)\n" })
                } catch {
                    print(error.localizedDescription)
                }
            case .setMain(let id):
                arranger.setAsMainDisplay(id: id, otherPositions: pendingPositions)
            case .undefined:
                print(DisplayArranger.TextOutput.undefined)
            }
        }
    }

    enum CommandType: String {
        case allowablePositions = "-allowablePositions"
        case displaysInfo = "-info"
        case help = "-h"
        case moveMouse = "-moveMouse"
        case otherPosition = "-otherPosition"
        case screenIds = "-screenIds"
        case setMain = "-setMain"
    }

    enum Command {
        case allowablePositions
        case displaysInfo
        case help
        case moveMouse(CGPoint)
        case otherPosition(ScreenPosition, referenceDisplay: DisplayId?)
        case screenIds
        case setMain(DisplayId)
        case undefined

        init?(arguments: [String]) {
            guard let command = arguments.first, let type = CommandType(rawValue: command) else {
                return nil
            }

            switch type {
            case .allowablePositions:
                self = .allowablePositions
                return
            case .displaysInfo:
                self = .displaysInfo
                return
            case .help:
                self = .help
                return
            case .moveMouse where arguments.count == 2:
                if let point = CGPoint(arguments.last) {
                    self = .moveMouse(point)
                    return
                }
            case .otherPosition where arguments.count == 2:
                if let position = ScreenPosition(arguments.last) {
                    self = .otherPosition(position, referenceDisplay: nil)
                    return
                }
            case .otherPosition where arguments.count == 3:
                if let position = ScreenPosition(arguments[1]), let id = DisplayId(arguments.last) {
                    self = .otherPosition(position, referenceDisplay: id)
                    return
                }
            case .setMain where arguments.count == 2:
                if let id = DisplayId(arguments.last) {
                    self = .setMain(id)
                    return
                }
            case .screenIds:
                self = .screenIds
                return
            default:
                return nil
            }
            return nil
        }
    }
}

fileprivate extension CGPoint {
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

fileprivate extension CGFloat {
    init?(_ string: String?) {
        guard let string = string, let doubleValue = Double(string) else {
            return nil
        }

        self.init(doubleValue)
    }
}

fileprivate extension DisplayId {
    init?(_ string: String?) {
        guard let string = string else {
            return nil
        }

        self.init(string)
    }
}
