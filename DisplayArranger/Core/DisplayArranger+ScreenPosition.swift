//
//  DisplayArranger+ScreenPosition.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

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
            print("Successfully set '\(id)' as main display")
        }

        for positionConfig in otherPositions where positionConfig.id != id {
            if let anchorFrame = displayInfo(for: positionConfig.anchorId)?.frame {
                setFrame(for: positionConfig, relativeTo: anchorFrame, config: &config)
            }
        }

        if case let status = CGCompleteDisplayConfiguration(config, .permanently), status != .success {
            print("Error: \(status.rawValue)")
        }
    }

    func setFrame(for positionConfig: PositionConfig, relativeTo other: CGRect, config: inout CGDisplayConfigRef?) {
        guard let size = displayInfo(for: positionConfig.id)?.frame.size else {
            fatalError("Unable to find display info for '\(positionConfig.id)'")
        }

        let origin = positionConfig.position.origin(with: size, relativeTo: other)

        if case let status = CGConfigureDisplayOrigin(config, positionConfig.id, Int32(origin.x), Int32(origin.y)), status != .success {
            print("Error: \(status.rawValue)")
        }

        print("Successfully positioned '\(positionConfig.id)' to '\(positionConfig.position.description)' of reference display")
    }
}
