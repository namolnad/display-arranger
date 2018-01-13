//
//  DisplayArranger+Help.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

extension DisplayArranger {

    func help() -> String {
        // FIXME: - adjust usage documentation to show new positioning logic
        return """
        Use display-arranger to get information about your current screens
        or for setting the main screen and the positions of your other
        connected screens, relative to the main screen.

        Usage: display-arranger
        [-h] Shows the help text
        [-info] Shows information about the connected screens
        [-screenIds] Returns the ids for all connected screens
        [-setMainId <Screen Id>] Pass the id of the screen that you want to make the main screen
        [-otherPosition <position>] Use this with -setMainID to determine placement of other screens
        [-allowablePositions] Displays a list of the allowable positions for -otherPosition command


        Examples:
        display-arranger -info
            Returns information about your attached screens including the Screen ID

        display-arranger -setMainID 69670848 -otherPosition onLeft-bottomAligned
            Makes the screen with the Screen ID 69670848 the main screen.
            Also positions other screens to the left, bottom-aligned to the main screen
            as shown under the \"Arrangement\" section of the Displays preference pane.

        NOTE: Global Position {0, 0} coordinate (as shown under -info)
            is the lower left corner of the main screen

        """
    }

    func undefined() -> String {
        return "Undefined argument. -h shows help."
    }
}
