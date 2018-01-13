//
//  DisplayArranger+ScreenIds.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

enum DisplayContext {
    case adjusting
    case informational
}

extension DisplayArranger {

    func activeDisplayIds(context: DisplayContext = .informational) throws -> Set<DisplayId> {
        var displayCount: CGDisplayCount = .init()

        CGGetActiveDisplayList(.max, nil, &displayCount)

        let activeDisplays: PointerArray<DisplayId> = .init(capacity: displayCount)

        switch CGGetActiveDisplayList(.max, activeDisplays.first, &displayCount) {
        case let result where result != .success:
            throw DisplayArrangerError.unavailable
        case _ where displayCount > 2 && context != .informational:
            throw DisplayArrangerError.tooManyScreens
        default:
            return Set(activeDisplays.array)
        }
    }
}
