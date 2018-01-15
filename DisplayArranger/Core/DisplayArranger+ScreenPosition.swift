//
//  DisplayArranger+ScreenPosition.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

extension DisplayArranger {

    func setAsMainDisplay(id: DisplayId, otherPositions positions: [DisplayId: ScreenPosition]? = nil) {
        let pointer: Pointer<CGDisplayConfigRef?> = .init(capacity: 1)

        var config: CGDisplayConfigRef? = .init(pointer.pointer)

        if case let status = CGBeginDisplayConfiguration(&config), status != .success {
            print("Error: \(status.rawValue)")
        }

        // Set display w/ id as main display
        if case let status = CGConfigureDisplayOrigin(config, id, 0, 0), status != .success {
            print("Error: \(status.rawValue)")
        } else {
            print("Successfully set display with id: \(id) as main display")
        }

        if let positions = positions, !positions.isEmpty, let referenceFrame = displayInfo(for: id)?.frame {
            setFrames(for: positions, relativeTo: referenceFrame, config: config)
        } else if case let status = CGCompleteDisplayConfiguration(config, .permanently), status != .success {
            print("Error: \(status.rawValue)")
        }
    }

    func setFrames(for positions: [DisplayId: ScreenPosition], relativeTo other: CGRect, config: CGDisplayConfigRef? = nil) {
        let pointer: Pointer<CGDisplayConfigRef?> = .init(capacity: 1)

        var positionsConfig: CGDisplayConfigRef? = config ?? .init(pointer.pointer)

        if config == nil, case let status = CGBeginDisplayConfiguration(&positionsConfig), status != .success {
            print("Error: \(status.rawValue)")
        }

        for (screenId, position) in positions {
            guard let info = displayInfo(for: screenId) else {
                fatalError("Unable to find screen info for id: \(screenId)")
            }
            let origin = position.origin(with: info.frame.size, relativeTo: other)
            if case let status = CGConfigureDisplayOrigin(positionsConfig, screenId, Int32(origin.x), Int32(origin.y)), status != .success {
                print("Error: \(status.rawValue)")
            }
            print("Successfully set display with id: \(screenId) to position: \(position.description)")
        }

        if case let status = CGCompleteDisplayConfiguration(positionsConfig, .permanently), status != .success {
            print("Error: \(status.rawValue)")
        }
    }
}
