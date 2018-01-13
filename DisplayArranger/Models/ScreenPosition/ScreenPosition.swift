//
//  ScreenPosition.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

struct ScreenPosition {
    let horizontal: Horizontal

    let vertical: Vertical

    init(_ value: String) throws {
        let position: ScreenPosition
        switch value.components(separatedBy: "-") {
        case let values where values.count == 2:
            guard
                let horizontal = Horizontal(rawValue: values[0]),
                let vertical = Vertical(rawValue: values[1]) else {
                throw DisplayArrangerError.malformedScreenPosition
            }
            position = .init(horizontal: horizontal, vertical: vertical)
            guard ScreenPosition.supportedPositions.contains(position) else {
                throw DisplayArrangerError.unsupportedScreenPosition
            }
        default:
            throw DisplayArrangerError.malformedScreenPosition
        }
        self.init(horizontal: position.horizontal, vertical: position.vertical)
    }

    private init(horizontal: Horizontal, vertical: Vertical) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

extension ScreenPosition: Hashable {
    var hashValue: Int {
        return horizontal.hashValue ^ vertical.hashValue
    }

    static func ==(lhs: ScreenPosition, rhs: ScreenPosition) -> Bool {
        return lhs.horizontal == rhs.horizontal &&
            lhs.vertical == rhs.vertical
    }
}

extension ScreenPosition: CustomStringConvertible {
    var description: String {
        return "\(horizontal.rawValue)-\(vertical.rawValue)"
    }
}

extension ScreenPosition {
    // On left
    static let onLeftTopAligned: ScreenPosition = .init(horizontal: .onLeft, vertical: .topAligned)
    static let onLeftBottomAligned: ScreenPosition = .init(horizontal: .onLeft, vertical: .bottomAligned)
    static let onLeftAbove: ScreenPosition = .init(horizontal: .onLeft, vertical: .above)
    static let onLeftBelow: ScreenPosition = .init(horizontal: .onLeft, vertical: .below)
    static let onLeftCentered: ScreenPosition = .init(horizontal: .onLeft, vertical: .centered)

    // On right
    static let onRightTopAligned: ScreenPosition = .init(horizontal: .onRight, vertical: .topAligned)
    static let onRightBottomAligned: ScreenPosition = .init(horizontal: .onRight, vertical: .bottomAligned)
    static let onRightAbove: ScreenPosition = .init(horizontal: .onRight, vertical: .above)
    static let onRightBelow: ScreenPosition = .init(horizontal: .onRight, vertical: .below)
    static let onRightCentered: ScreenPosition = .init(horizontal: .onRight, vertical: .centered)

    // Above
    static let aboveLeftAligned: ScreenPosition = .init(horizontal: .leftAligned, vertical: .above)
    static let aboveCentered: ScreenPosition = .init(horizontal: .centered, vertical: .above)
    static let aboveRightAligned: ScreenPosition = .init(horizontal: .rightAligned, vertical: .above)

    // Below
    static let belowLeftAligned: ScreenPosition = .init(horizontal: .leftAligned, vertical: .below)
    static let belowCentered: ScreenPosition = .init(horizontal: .centered, vertical: .below)
    static let belowRightAligned: ScreenPosition = .init(horizontal: .rightAligned, vertical: .below)
}
