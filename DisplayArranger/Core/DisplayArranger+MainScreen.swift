//
//  DisplayArranger+MainScreen.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

extension DisplayArranger {

    func setAsMainDisplay(id: DisplayId, otherPositions: [DisplayId: ScreenPosition]) throws {
        var displayCount: CGDisplayCount = .init()

        CGGetActiveDisplayList(.max, nil, &displayCount)

        let activeDisplays: PointerArray<DisplayId> = .init(capacity: displayCount)

        switch CGGetActiveDisplayList(.max, activeDisplays.first, &displayCount) {
        case let result where result != .success:
            throw DisplayArrangerError.unavailable
        case _ where displayCount > 2:
            throw DisplayArrangerError.tooManyScreens
        default:
            break
        }

        let pointer: Pointer<CGDisplayConfigRef?> = .init(capacity: 1)

        var config: CGDisplayConfigRef? = .init(pointer.pointer)


        if case let status = CGBeginDisplayConfiguration(&config), status != .success {
            print("Error: \(status.rawValue)")
        }

        if case let status = CGConfigureDisplayOrigin(config, id, 0, 0), status != .success {
            print("Error: \(status.rawValue)")
        }

        // FIXME: - should probably return a dictionary here
        let screenInfo = displaysInfo()

        guard let mainInfo = screenInfo.first(where: { $0.id == id }) else {
            fatalError("Main screen info not found")
        }

        for (screenId, position) in otherPositions {
            guard let info = screenInfo.first(where: { $0.id == screenId }) else {
                fatalError("Unable to find screen info for id: \(screenId)")
            }
            let origin = position.origin(with: info.frame.size, relativeTo: mainInfo.frame)
            if case let status = CGConfigureDisplayOrigin(config, screenId, Int32(origin.x), Int32(origin.y)), status != .success {
                print("Error: \(status.rawValue)")
            }
        }

        if case let status = CGCompleteDisplayConfiguration(config, .permanently), status != .success {
            print("Error: \(status.rawValue)")
        }
    }
}
