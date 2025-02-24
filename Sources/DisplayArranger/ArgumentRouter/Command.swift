import CoreGraphics

enum Command {
    case help
    case version

    case info
    case listIds
    case listPositions

    case primary(DisplayId)
    case arrange(IntendedPosition)
    case mouse(CGPoint)

    case undefined

    init?(arguments: [String]) {
        guard let type = arguments.first, let commandType = CommandType(rawValue: type) else {
            return nil
        }

        switch commandType {
        case .help:
            self = .help
            return
        case .version:
            self = .version
            return
        case .info:
            self = .info
            return
        case .listIds:
            self = .listIds
            return
        case .listPositions:
            self = .listPositions
            return
        case .primary where arguments.count == 2:
            if let id = DisplayId(arguments.last) {
                self = .primary(id)
                return
            }
        case .arrange where arguments.count == 4:
            if let id = DisplayId(arguments[1]), let position = ScreenPosition(arguments[2]), let anchorId = DisplayId(arguments.last) {
                self = .arrange(.init(id: id, position: position, anchorId: anchorId))
                return
            }
        case .arrange where arguments.count == 3:
            if let id = DisplayId(arguments[1]), let position = ScreenPosition(arguments.last) {
                self = .arrange(.init(id: id, position: position, anchorId: nil))
                return
            }
        case .mouse where arguments.count == 2:
            if let point = CGPoint(arguments.last) {
                self = .mouse(point)
                return
            }
        default:
            return nil
        }
        return nil
    }
}
