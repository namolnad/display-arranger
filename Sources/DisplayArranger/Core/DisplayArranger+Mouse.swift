import CoreGraphics

final class DisplayArranger {
    func moveCursor(to: CGPoint, onScreen id: DisplayId) {
        guard case let status = CGDisplayMoveCursorToPoint(id, to), status != .success else { return }

        print("Error: \(status.rawValue)")
    }
}
