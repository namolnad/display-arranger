import CoreGraphics

extension ScreenPosition {
    enum Horizontal: String {
        case centered
        case onLeft = "on-left"
        case onRight = "on-right"
        case leftAligned = "left-aligned"
        case rightAligned = "right-aligned"
    }

    enum Vertical: String {
        case above
        case below
        case centered
        case bottomAligned = "bottom-aligned"
        case topAligned = "top-aligned"
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
