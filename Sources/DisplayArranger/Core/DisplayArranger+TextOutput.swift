extension DisplayArranger {
    static var textOutput: TextOutput { .init() }
}

extension DisplayArranger {
    struct TextOutput {
        fileprivate init() {}

        var version: String { "v0.3.0" }

        var help: String {
            """

            Use display-arranger to get information about your current displays,
            for setting the main display, and for setting the positions of your other
            connected displays relative to another display's position (defaults to main)

            Usage: display-arranger

            # Basic/Info commands
            [-h, --help] Shows the help text
            [-v, --version] Shows the version of the application

            # Query/List commands
            [-i, --info] Shows information about the connected displays
            [-l, --list-displays] Returns the ids for all connected displays
            [-L, --list-positions] Displays a list of the supported positions for --arrange argument

            # Action commands
            [-p, --primary <DisplayId>] Pass the id of the display that you want to make the primary display (dock/menu bar)
            [-a, --arrange <DisplayId> <Position> <ReferenceDisplayId>] Used in conjunction with --primary to
            control the position of your other displays. Order is important, see README for additional usage details.
            [-m, --mouse] Moves the mouse cursor to the given coordinates on the main display (example: 100,100)


            Examples:
            display-arranger --info
            Returns information about your attached displays

            display-arranger --primary 69670848 -o 54019204 on-left:bottom-aligned
            Makes the display with the DisplayId 69670848 the main display and
            positions 54019204 to the left of, and bottom-aligned to, the main display

            Note: Global Position's origin is the upper-left corner of the display

            """
        }

        var undefined: String {
            """

            Undefined argument/s. -h shows help.

            """
        }

        var supportedPositions: String {
            """

            on-left:top-aligned
            on-left:bottom-aligned
            on-left:below
            on-left:above
            on-left:centered
            on-right:top-aligned
            on-right:bottom-aligned
            on-right:below
            on-right:above
            on-right:centered
            above:left-aligned
            above:centered
            above:right-aligned
            below:left-aligned
            below:centered
            below:right-aligned

            """
        }
    }
}
