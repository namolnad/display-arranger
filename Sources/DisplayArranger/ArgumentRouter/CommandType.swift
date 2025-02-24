enum CommandType {
    case help
    case version

    case info
    case listDisplays
    case listPositions

    case primary
    case arrange
    case mouse
}

extension CommandType {
    init?(rawValue: String) {
        switch rawValue {
        case "-i", "--info":
            self = .info
        case "-v", "--version":
            self = .version
        case "-h", "--help":
            self = .help
        case "-l", "--list-displays":
            self = .listDisplays
        case "-L", "--list-positions":
            self = .listPositions
        case "-p", "--primary":
            self = .primary
        case "-a", "--arrange":
            self = .arrange
        case "-m", "--mouse":
            self = .mouse
        default:
            return nil
        }
    }
}

