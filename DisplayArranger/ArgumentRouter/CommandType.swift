enum CommandType {
    case displaysInfo
    case help
    case ids
    case moveMouse
    case op
    case otherPosition
    case setMain
    case supportedPositions
}

extension CommandType {
    init?(rawValue: String) {
        switch rawValue {
        case "-i", "-info":
            self = .displaysInfo
        case "-h", "-help":
            self = .help
        case "-ids":
            self = .ids
        case "-moveMouse":
            self = .moveMouse
        case "-op", "-otherPosition":
            self = .otherPosition
        case "-setMain":
            self = .setMain
        case "-supportedPositions":
            self = .supportedPositions
        default:
            return nil
        }
    }
}

