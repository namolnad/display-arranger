struct ScreenPosition {
    let horizontal: Horizontal

    let vertical: Vertical

    init?(_ value: String?) {
        guard let value = value else {
            return nil
        }
        guard case let components = value.components(separatedBy: "-"), components.count == 2 else {
            return nil
        }
        guard let first = components.first, let horizontal = Horizontal(rawValue: first) else {
            return nil
        }
        guard let last = components.last, let vertical = Vertical(rawValue: last) else {
            return nil
        }
        guard type(of: self).supportedPositions.contains(.init(horizontal: horizontal, vertical: vertical)) else {
            return nil
        }

        self.init(horizontal: horizontal, vertical: vertical)
    }

    private init(horizontal: Horizontal, vertical: Vertical) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

extension ScreenPosition: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(horizontal)
        hasher.combine(vertical)
    }

    static func ==(lhs: ScreenPosition, rhs: ScreenPosition) -> Bool {
        lhs.horizontal == rhs.horizontal && lhs.vertical == rhs.vertical
    }
}

extension ScreenPosition: CustomStringConvertible {
    var description: String { "\(horizontal.rawValue)-\(vertical.rawValue)" }
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
