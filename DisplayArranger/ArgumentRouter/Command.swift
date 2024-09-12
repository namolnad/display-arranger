import CoreGraphics

enum Command {
    case displaysInfo
    case help
    case ids
    case moveMouse(CGPoint)
    case otherPosition(IntendedPosition)
    case setMain(DisplayId)
    case supportedPositions
    case undefined

    init?(arguments: [String]) {
        guard let type = arguments.first, let commandType = CommandType(rawValue: type) else {
            return nil
        }

        switch commandType {
        case .displaysInfo:
            self = .displaysInfo
            return
        case .help:
            self = .help
            return
        case .ids:
            self = .ids
            return
        case .moveMouse where arguments.count == 2:
            if let point = CGPoint(arguments.last) {
                self = .moveMouse(point)
                return
            }
        case .otherPosition where arguments.count == 3, .op where arguments.count == 3:
            if let id = DisplayId(arguments[1]), let position = ScreenPosition(arguments.last) {
                self = .otherPosition(.init(id: id, position: position, anchorId: nil))
                return
            }
        case .otherPosition where arguments.count == 4, .op where arguments.count == 3:
            if let id = DisplayId(arguments[1]), let position = ScreenPosition(arguments[2]), let anchorId = DisplayId(arguments.last) {
                self = .otherPosition(.init(id: id, position: position, anchorId: anchorId))
                return
            }
        case .setMain where arguments.count == 2:
            if let id = DisplayId(arguments.last) {
                self = .setMain(id)
                return
            }
        case .supportedPositions:
            self = .supportedPositions
            return
        default:
            return nil
        }
        return nil
    }
}
