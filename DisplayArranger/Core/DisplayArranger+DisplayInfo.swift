import AppKit

extension DisplayArranger {
    func displaysInfo() -> [DisplayInfo] {
        NSScreen.screens.compactMap(DisplayInfo.init)
    }

    func displayInfo(for displayId: DisplayId) -> DisplayInfo? {
        displaysInfo().first { $0.id == displayId }
    }
}
