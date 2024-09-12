import CoreGraphics

extension DisplayArranger {

    func setAsMainDisplay(id: DisplayId, otherPositions: [PositionConfig]) {
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

    func setFrame(for positionConfig: PositionConfig, relativeTo other: CGRect, config: inout CGDisplayConfigRef?) -> CGRect {
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
}
