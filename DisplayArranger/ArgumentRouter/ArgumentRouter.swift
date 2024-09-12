final class ArgumentRouter {
    func route(args: [String], arranger: DisplayArranger) {
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

        commands.forEach {
            switch $0 {
            case .displaysInfo:
                print(arranger.displaysInfo().reduce("\n") { $0 + "\($1.description)\n" })
            case .help:
                print(DisplayArranger.TextOutput.help)
            case .moveMouse(let point):
                if let id = arranger.displaysInfo().first?.id {
                    arranger.moveCursor(to: point, onScreen: id)
                }
            case let .otherPosition(pending):
                if let anchorId = pending.anchorId {
                    positionConfigs.append(.init(id: pending.id, position: pending.position, anchorId: anchorId))
                } else {
                    intendedMissingAnchor.append(pending)
                }
            case .ids:
                do {
                    print(try arranger.activeDisplayIds().reduce("\n") { $0 + "\($1)\n" })
                } catch {
                    print(error.localizedDescription)
                }
            case .setMain(let id):
                let configs: [PositionConfig] = intendedMissingAnchor
                    .compactMap { .init(id: $0.id, position: $0.position, anchorId: id) }

                positionConfigs.insert(contentsOf: configs, at: 0)

                arranger.setAsMainDisplay(id: id, otherPositions: positionConfigs)
            case .supportedPositions:
                print(DisplayArranger.TextOutput.supportedPositions)
            case .undefined:
                print("\nArguments received: \(arguments)")

                print(DisplayArranger.TextOutput.undefined)
            }
        }
    }
}
