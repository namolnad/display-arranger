//
//  StartingPosition.swift
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

    enum Horizontal: String {
        case centered
        case onLeft
        case onRight
        case leftAligned
        case rightAligned
    }

    enum Vertical: String {
        case above
        case below
        case centered
        case bottomAligned
        case topAligned
    }

    func origin(with size: CGSize, relativeTo other: CGRect) -> CGPoint {
        let xOrigin: CGFloat = horizontal.origin(size: size, relativeTo: other)
        let yOrigin: CGFloat = vertical.origin(size: size, relativeTo: other)

        return .init(x: xOrigin, y: yOrigin)
    }
}

extension ScreenPosition.Horizontal {
    func origin(size: CGSize, relativeTo other: CGRect) -> CGFloat {
        switch self {
        case .centered:
            return (other.minX + (other.size.width / 2)) - (size.width / 2)
        case .leftAligned:
            return other.minY
        case .rightAligned:
            return other.maxY - size.width
        case .onLeft:
            return other.minY - size.width
        case .onRight:
            return other.maxY
        }
    }
}

extension ScreenPosition.Vertical {
    func origin(size: CGSize, relativeTo other: CGRect) -> CGFloat {
        switch self {
        case .above:
            return other.origin.y - size.height
        case .below:
            return other.maxY
        case .centered:
            return (other.minY + (other.size.height / 2)) - (size.height / 2)
        case .bottomAligned:
            return other.maxY - size.height
        case .topAligned:
            return other.minY
        }
    }
}

extension ScreenPosition {
    static var supportedPositions: Set<ScreenPosition> = [
        onLeftTopAligned,
        onLeftBottomAligned,
        onRightTopAligned,
        onRightBottomAligned,
        aboveLeftAligned,
        aboveCentered,
        aboveRightAligned,
        belowLeftAligned,
        belowCentered,
        belowRightAligned
    ]

    // On left
    private static let onLeftTopAligned: ScreenPosition = .init(horizontal: .onLeft, vertical: .topAligned)
    private static let onLeftBottomAligned: ScreenPosition = .init(horizontal: .onLeft, vertical: .bottomAligned)
//    private static let onLeftAbove: ScreenPosition = .init(horizontal: .onLeft, vertical: .above)
//    private static let onLeftBelow: ScreenPosition = .init(horizontal: .onLeft, vertical: .below)

    // On right
    private static let onRightTopAligned: ScreenPosition = .init(horizontal: .onRight, vertical: .topAligned)
    private static let onRightBottomAligned: ScreenPosition = .init(horizontal: .onRight, vertical: .bottomAligned)

    // Above
    private static let aboveLeftAligned: ScreenPosition = .init(horizontal: .leftAligned, vertical: .above)
    private static let aboveCentered: ScreenPosition = .init(horizontal: .centered, vertical: .above)
    private static let aboveRightAligned: ScreenPosition = .init(horizontal: .rightAligned, vertical: .above)

    // Below
    private static let belowLeftAligned: ScreenPosition = .init(horizontal: .leftAligned, vertical: .below)
    private static let belowCentered: ScreenPosition = .init(horizontal: .centered, vertical: .below)
    private static let belowRightAligned: ScreenPosition = .init(horizontal: .rightAligned, vertical: .below)
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

