//
//  DisplayArranger+DisplayInfo.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import AppKit

extension DisplayArranger {

    func displaysInfo() -> [DisplayInfo] {
        return NSScreen.screens
            .flatMap(DisplayInfo.init)
    }

    func info(for displayId: Int) -> DisplayInfo? {
        return displaysInfo().first(where: { $0.id == UInt32(displayId) })
    }
}
