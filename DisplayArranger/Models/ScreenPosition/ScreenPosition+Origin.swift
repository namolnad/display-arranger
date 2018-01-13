//
//  ScreenPosition+Horizontal.swift
//  display-arranger
//
//  Created by Dan Loman on 1/12/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

extension ScreenPosition {
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
}

extension ScreenPosition.Horizontal {
    func origin(size: CGSize, relativeTo other: CGRect) -> CGFloat {
        switch self {
        case .centered:
            return (other.minX + (other.size.width / 2)) - (size.width / 2)
        case .leftAligned:
            return other.minX
        case .rightAligned:
            return other.maxX - size.width
        case .onLeft:
            return other.minX - size.width
        case .onRight:
            return other.maxX
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
    func origin(with size: CGSize, relativeTo other: CGRect) -> CGPoint {
        return .init(
            x: horizontal.origin(size: size, relativeTo: other),
            y: vertical.origin(size: size, relativeTo: other)
        )
    }
}
