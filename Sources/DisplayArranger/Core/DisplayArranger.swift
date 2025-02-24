import CoreGraphics
import AppKit

struct DisplayArranger {
    private init() {}

    // MARK: - Display Ids
    static func activeDisplayIds() throws -> Set<DisplayId> {
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

    // MARK: - Display Info
    static func displaysInfo() -> [DisplayInfo] {
        NSScreen.screens.compactMap(DisplayInfo.init)
    }

    static func displayInfo(for displayId: DisplayId) -> DisplayInfo? {
        displaysInfo().first { $0.id == displayId }
    }

    // MARK: Screen Position
    static func setAsPrimaryDisplay(id: DisplayId, otherPositions: [PositionConfig]) {
        let pointer: Pointer<CGDisplayConfigRef?> = .init(capacity: 1)

        var config: CGDisplayConfigRef? = .init(pointer.pointer)

        if case let status = CGBeginDisplayConfiguration(&config), status != .success {
            print("Error: \(status.rawValue)")
        }

        // Set display w/ id as main display
        if case let status = CGConfigureDisplayOrigin(config, id, 0, 0), status != .success {
            print("Error: \(status.rawValue)")
        } else {
            print("\nSuccessfully set '\(id)' as main display")
        }

        var frames: [DisplayId: CGRect] = [:]

        if let size = displayInfo(for: id)?.frame.size {
            frames[id] = CGRect(origin: .zero, size: size)
        }

        for positionConfig in otherPositions where positionConfig.id != id {
            if let anchorFrame = frames[positionConfig.anchorId] {
                let frame = setFrame(for: positionConfig, relativeTo: anchorFrame, config: &config)
                frames[positionConfig.id] = frame
            }
        }

        if case let status = CGCompleteDisplayConfiguration(config, .permanently), status != .success {
            print("Error: \(status.rawValue)")
        }
    }

    static func setFrame(for positionConfig: PositionConfig, relativeTo other: CGRect, config: inout CGDisplayConfigRef?) -> CGRect {
        guard let size = displayInfo(for: positionConfig.id)?.frame.size else {
            fatalError("Unable to find display info for '\(positionConfig.id)'")
        }

        let origin = positionConfig.position.origin(with: size, relativeTo: other)

        if case let status = CGConfigureDisplayOrigin(config, positionConfig.id, Int32(origin.x), Int32(origin.y)), status != .success {
            print("Error: \(status.rawValue)")
        }

        print("Successfully positioned '\(positionConfig.id)' to '\(positionConfig.position.description)' of reference display\n")

        return .init(origin: origin, size: size)
    }

    // MARK: - Mouse
    static func moveCursor(to: CGPoint, onScreen id: DisplayId) {
        guard case let status = CGDisplayMoveCursorToPoint(id, to), status != .success else { return }

        print("Error: \(status.rawValue)")
    }
}
