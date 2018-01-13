//
//  ScreenPositions+Allowed.swift
//  display-arranger
//
//  Created by Dan Loman on 1/12/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

extension ScreenPosition {
    static var supportedPositions: Set<ScreenPosition> = [
        onLeftTopAligned,
        onLeftBottomAligned,
        onLeftBelow,
        onLeftAbove,
        onLeftCentered,
        onRightTopAligned,
        onRightBottomAligned,
        onRightBelow,
        onRightAbove,
        onRightCentered,
        aboveLeftAligned,
        aboveCentered,
        aboveRightAligned,
        belowLeftAligned,
        belowCentered,
        belowRightAligned
    ]
}
