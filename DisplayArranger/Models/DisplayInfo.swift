//
//  DisplayInfo.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/12/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import AppKit

typealias DisplayId = UInt32

struct DisplayInfo {
    let id: DisplayId

    var frame: CGRect

    var globalPosition: String {
        return "(Origin: \(frame.origin)), Termination: (\(frame.origin.x + frame.size.width), \(frame.origin.y + frame.size.height)))"
    }

    let colorSpace: NSColorSpace?

    let bitsPerSample: Int

    let resolution: CGSize

    let refreshRate: Double

    let usesQuartzExtreme: Bool

    init?(screen: NSScreen) {
        guard let id = (screen.deviceDescription[.init("NSScreenNumber")] as? NSNumber)?.uint32Value else {
            debugPrint("Unable to parse screenId from NSScreen.deviceDescription")
            return nil
        }

        self.id = id
        self.frame = screen.frame
        self.colorSpace = screen.colorSpace
        self.bitsPerSample = (screen.deviceDescription[.bitsPerSample] as? Int) ?? 0
        self.resolution = (screen.deviceDescription[.resolution] as? CGSize) ?? .zero
        self.refreshRate = CGDisplayCopyDisplayMode(id)?.refreshRate ?? 0
        self.usesQuartzExtreme = CGDisplayUsesOpenGLAcceleration(id) == 1
    }
}

extension DisplayInfo: CustomStringConvertible {
    var description: String {
        var buffer: String = "Screen Id: \(id)\n"

        buffer.append("Global Position: \(globalPosition)\n")

        if let colorSpace = colorSpace {
            buffer.append("Color Space: \(colorSpace)\n")
        }

        buffer.append("Bits per sample: \(bitsPerSample)\n")

        buffer.append("Resolution (dpi): \(resolution)\n")

        buffer.append("Refresh rate: \(refreshRate)\n")

        buffer.append("Uses Quartz Extreme: \(usesQuartzExtreme)\n")

        return buffer
    }
}
