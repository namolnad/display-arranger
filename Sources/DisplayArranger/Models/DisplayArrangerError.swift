import Foundation

enum DisplayArrangerError: LocalizedError {
    case unavailable
    case tooManyScreens
    case malformedScreenPosition
    case unsupportedScreenPosition
    case screenPositionParsing

    var localizedDescription: String? {
        let description: String
        switch self {
        case .unavailable:
            description = "Can't get displays"
        case .tooManyScreens:
            description = "display-arranger can handle a max of 2 screens when adjusting the primary screen position"
        case .malformedScreenPosition:
            description = "Screen position can not be parsed from argument. See -h for examples"
        case .unsupportedScreenPosition:
            description = "Screen position not currently supported"
        case .screenPositionParsing:
            description = "Unable to determine screen position; Ensure multiple screens connected. See -h for examples"
        }
        return "Error: \(description)"
    }
}
