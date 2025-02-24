extension DisplayArranger {
    struct TextOutput {
        static var help: String {
            """

            Use display-arranger to get information about your current displays,
            for setting the main display, and for setting the positions of your other
            connected displays relative to another display's position (defaults to main)

            Usage: display-arranger
            [-h, --help] Shows the help text
            [--ids] Returns the ids for all connected displays
            [-i, --info] Shows information about the connected displays
            [--moveMouse] Moves the mouse cursor to the given coordinates on the main display (example: 100-100)
            [--setMain <DisplayId>] Pass the id of the display that you want to make the main display (dock/menu bar)
            [--supportedPositions] Displays a list of the supported positions for --otherPosition command
            [-op, --otherPosition <DisplayId> <Position> <ReferenceDisplayId>] Used in conjunction with --setMain to
            control the position of your other displays. Order is important, see README for additional usage details.


            Examples:
            display-arranger --info
            Returns information about your attached displays

            display-arranger --setMain 69670848 -op 54019204 onLeft-bottomAligned
            Makes the display with the DisplayId 69670848 the main display and
            positions 54019204 to the left of, bottom-aligned to, the main display

            Note: Global Position's origin is the upper-left corner of the display

            """
        }

        static var undefined: String {
            """

            Undefined argument/s. -h shows help.

            """
        }

        static var supportedPositions: String {
            """

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
