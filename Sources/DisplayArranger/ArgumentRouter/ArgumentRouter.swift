final class ArgumentRouter {
    func route(args: [String]) {
        var arguments = args
        // Remove first argument as it is simply the call to display-arranger
        arguments.removeFirst()

        var commands: [Command] = []
        var pendingArguments: [String] = []

        for arg in arguments.reversed() {
            if let command = Command(arguments: [arg] + pendingArguments.reversed()) {
                pendingArguments.removeAll()
                commands.append(command)
            } else {
                pendingArguments.append(arg)
            }
        }

        if commands.isEmpty {
            commands.append(arguments.isEmpty ? .help : .undefined)
        }

        var intendedMissingAnchor: [IntendedPosition] = []
        var positionConfigs: [PositionConfig] = []

        commands.forEach { command in
            switch command {
            case .help:
                print(DisplayArranger.textOutput.help)
            case .info:
                print(DisplayArranger.displaysInfo().reduce("\n") { $0 + "\($1.description)\n" })
            case .mouse(let point):
                if let id = DisplayArranger.displaysInfo().first?.id {
                    DisplayArranger.moveCursor(to: point, onScreen: id)
                }
            case .listDisplays:
                do {
                    print(try DisplayArranger.activeDisplayIds().reduce("\n") { $0 + "\($1)\n" })
                } catch {
                    print(error.localizedDescription)
                }
            case .listPositions:
                print(DisplayArranger.textOutput.supportedPositions)
            case .primary(let id):
                let configs: [PositionConfig] = intendedMissingAnchor
                    .compactMap { .init(id: $0.id, position: $0.position, anchorId: id) }

                positionConfigs.insert(contentsOf: configs, at: 0)

                DisplayArranger.setAsPrimaryDisplay(id: id, otherPositions: positionConfigs)
            case let .arrange(pending):
                if let anchorId = pending.anchorId {
                    positionConfigs.append(.init(id: pending.id, position: pending.position, anchorId: anchorId))
                } else {
                    intendedMissingAnchor.append(pending)
                }
            case .version:
                print(DisplayArranger.textOutput.version)
            case .undefined:
                print("\nArguments received: \(arguments)")

                print(DisplayArranger.textOutput.undefined)
            }
        }
    }
}
