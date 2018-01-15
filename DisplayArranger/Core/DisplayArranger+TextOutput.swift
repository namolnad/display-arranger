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
            for setting the main screen, and for setting the positions of your other
            connected screens (relative to the main-screen's position.)

            Usage: display-arranger
            [-h] Shows the help text
            [-info] Shows information about the connected screens
            [-screenIds] Returns the ids for all connected screens
            [-setMain <ScreenId>] Pass the id of the screen that you want to make the main screen
            [-otherPosition <Position>] Use this with -setMain to determine placement of other screens
            [-allowablePositions] Displays a list of the allowable positions for -otherPosition command
            [-moveMouse] Moves the mouse cursor to the given coordinates on the main screen (example: 100-100)


            Examples:
            display-arranger -info
            Returns information about your attached screens including the Screen ID

            display-arranger -setMain 69670848 -otherPosition onLeft-bottomAligned
            Makes the screen with the ScreenId 69670848 the main screen.
            Also positions other screens to the left, bottom-aligned to the main screen
            as shown under the \"Arrangement\" section of the Displays preference pane.

            NOTE: Global Position {0, 0} coordinate (as shown under -info)
            is the upper left corner of the main screen

            """
        }

        static var undefined: String {
            return """

            Undefined argument. -h shows help.
            
            """
        }

        static var allowablePositions: String {
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
