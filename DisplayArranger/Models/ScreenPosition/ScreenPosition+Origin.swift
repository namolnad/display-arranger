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
    func origin(size: CGSize, relativeTo reference: CGRect) -> CGFloat {
        switch self {
        case .centered:
            return reference.midX - (size.width / 2)
        case .leftAligned:
            return reference.minX
        case .rightAligned:
            return reference.maxX - size.width
        case .onLeft:
            return reference.minX - size.width
        case .onRight:
            return reference.maxX
        }
    }
}

extension ScreenPosition.Vertical {
    func origin(size: CGSize, relativeTo reference: CGRect) -> CGFloat {
        switch self {
        case .above:
            return reference.minY - size.height
        case .below:
            return reference.maxY
        case .centered:
            return reference.midY - (size.height / 2)
        case .bottomAligned:
            return reference.maxY - size.height
        case .topAligned:
            return reference.minY
        }
    }
}

extension ScreenPosition {
    func origin(with size: CGSize, relativeTo reference: CGRect) -> CGPoint {
        return .init(
            x: horizontal.origin(size: size, relativeTo: reference),
            y: vertical.origin(size: size, relativeTo: reference)
        )
    }
}
