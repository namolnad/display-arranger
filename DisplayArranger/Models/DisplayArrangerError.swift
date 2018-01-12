//
//  DisplayArrangerError.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/12/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

enum DisplayArrangerError: LocalizedError {
    case unavailable
    case tooManyScreens

    var errorDescription: String? {
        let description: String
        switch self {
        case .unavailable:
            description = "Can't get displays"
        case .tooManyScreens:
            description = "display-arranger can handle a max of 5 screens when adjusting the main screen"
        }
        return "Error: \(description)"
    }
}
