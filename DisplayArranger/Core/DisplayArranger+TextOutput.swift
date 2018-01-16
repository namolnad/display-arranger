//
//  DisplayArranger+TextOutput.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

extension DisplayArranger {
    struct TextOutput {
        static var help: String {
            // FIXME: - adjust usage documentation to show new positioning logic
            return """

            Use display-arranger to get information about your current displays,
            for setting the main display, and for setting the positions of your other
            connected displays relative to another display's position (defaults to main)

            Usage: display-arranger
            [-h] Shows the help text
            [-ids] Returns the ids for all connected displays
            [-info] Shows information about the connected displays
            [-moveMouse] Moves the mouse cursor to the given coordinates on the main display (example: 100-100)
            [-setMain <DisplayId>] Pass the id of the display that you want to make the main display
            [-supportedPositions] Displays a list of the supported positions for -otherPosition command
            [-otherPosition <Position>] Use this with -setMain to determine placement of other displays


            Examples:
            display-arranger -info
            Returns information about your attached displays including the DisplayId

            display-arranger -setMain 69670848 -otherPosition onLeft-bottomAligned
            Makes the display with the DisplayId 69670848 the main display and
            positions other displays to the left, bottom-aligned to the main display
            as shown under the \"Arrangement\" section of the Displays preference pane.

            NOTE: Global Position {0, 0} coordinate (as shown under -info)
            is the upper left corner of the main display

            """
        }

        static var undefined: String {
            return """

            Undefined argument/s. -h shows help.
            
            """
        }

        static var supportedPositions: String {
            return """

            onLeft-topAligned
            onLeft-bottomAligned
            onLeft-below
            onLeft-above
            onLeft-centered
            onRight-topAligned
            onRight-bottomAligned
            onRight-below
            onRight-above
            onRight-centered
            above-leftAligned
            above-centered
            above-rightAligned
            below-leftAligned
            below-centered
            below-rightAligned

            """
        }
    }
}
