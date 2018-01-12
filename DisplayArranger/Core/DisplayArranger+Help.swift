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
        return """
        Use display-arranger to either get information about your screens
        or for setting the main screen (the screen with the menu bar).

        Usage: display-arranger
        [-h] shows the help text
        [-info] shows information about the connected screens
        [-screenIDs] returns only the screen IDs for the connected screens
        [-setMainID <Screen ID>] Screen ID of the screen that you want to make the main screen
        [-othersStartingPosition <position>] left, right, top, or bottom
        \t\tuse this with -setMainID to determine placement of other screens

        Examples:
        display-arranger -info
        \treturns information about your attached screens including the Screen ID

        display-arranger -setMainID 69670848 -othersStartingPosition left
        \tmakes the screen with the Screen ID 69670848 the main screen.
        \tAlso positions other screens to the left of the main screen as shown
        \tunder the \"Arrangement\" section of the Displays preference pane.

        NOTE: Global Position {0, 0} coordinate (as shown under -info)
        \tis the lower left corner of the main screen

        """
    }

    func undefined() -> String {
        return "Undefined argument. -h shows help."
    }
}
