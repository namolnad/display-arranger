import CoreGraphics

extension DisplayArranger {

    func activeDisplayIds() throws -> Set<DisplayId> {
        var displayCount: CGDisplayCount = .init()

        CGGetActiveDisplayList(.max, nil, &displayCount)

        let activeDisplays: PointerArray<DisplayId> = .init(capacity: displayCount)

        switch CGGetActiveDisplayList(.max, activeDisplays.first, &displayCount) {
        case let result where result != .success:
            throw DisplayArrangerError.unavailable
        default:
            return Set(activeDisplays.array)
        }
    }
}
