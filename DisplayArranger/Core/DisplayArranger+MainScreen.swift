//
//  DisplayArranger+MainScreen.swift
//  DisplayArranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//

import Foundation

extension DisplayArranger {

    func setAsMainDisplay(id: DisplayId, otherPositions: [DisplayId: ScreenPosition]) throws {
        var displayCount: CGDisplayCount = .init()

        CGGetActiveDisplayList(.max, nil, &displayCount)

        let activeDisplays: PointerArray<DisplayId> = .init(capacity: displayCount)

        switch CGGetActiveDisplayList(.max, activeDisplays.first, &displayCount) {
        case let result where result != .success:
            throw DisplayArrangerError.unavailable
        case _ where displayCount > 5:
            throw DisplayArrangerError.tooManyScreens
        default:
            return
        }

        

        //
        //    // validate that the screenID exists and get the index number of it
        //    int i, newMainScreenIndex;
        //    BOOL foundScreenID = NO;
        //    for (i=0; i<displayCount; i++) {
        //        CGDirectDisplayID thisDisplayID = activeDisplays[i];
        //        NSString* thisDisplayIDString = [NSString stringWithFormat:@"%i", thisDisplayID];
        //        if ([thisDisplayIDString isEqualToString:screenID]) {
        //            foundScreenID = YES;
        //            break;
        //        }
        //    }
        //
        //    if (foundScreenID) {
        //        newMainScreenIndex = i;
        //    } else {
        //        printf("Error: Screen ID %s could not be found\n", [screenID UTF8String]);
        //        return;
        //    }
        //
        //    // construct othersPos array which determines how we position the other displays
        //    NSArray* othersPos;
        //    if ([othersStartingPosition isEqualToString:@"left"]) {
        //        othersPos = [NSArray arrayWithObjects:@"left", @"right", @"top", @"bottom", nil];
        //    } else if ([othersStartingPosition isEqualToString:@"right"]) {
        //        othersPos = [NSArray arrayWithObjects:@"right", @"left", @"top", @"bottom", nil];
        //    } else if ([othersStartingPosition isEqualToString:@"top"]) {
        //        othersPos = [NSArray arrayWithObjects:@"top", @"bottom", @"left", @"right", nil];
        //    } else if ([othersStartingPosition isEqualToString:@"bottom"]) {
        //        othersPos = [NSArray arrayWithObjects:@"bottom", @"top", @"left", @"right", nil];
        //    } else {
        //        othersPos = [NSArray arrayWithObjects:@"left", @"right", @"top", @"bottom", nil];
        //    }
        //
        //    // configure the displays
        //    int othersCount = 0;
        //    CGBeginDisplayConfiguration(&config);
        //    for(i=0; i<displayCount; i++) {
        //        if (i == newMainScreenIndex) { // make this one the main screen
        //            CGConfigureDisplayOrigin(config, activeDisplays[i], 0, 0); //Set the as the new main display by positionning at 0,0
        //        } else {
        //            NSString* thisPos = [othersPos objectAtIndex:othersCount];
        //
        //            if ([thisPos isEqualToString:@"left"]) {
        //                CGConfigureDisplayOrigin(config, activeDisplays[i], -1*CGDisplayPixelsWide(activeDisplays[i]), 0);
        //            } else if ([thisPos isEqualToString:@"right"]) {
        //                CGConfigureDisplayOrigin(config, activeDisplays[i], CGDisplayPixelsWide(activeDisplays[newMainScreenIndex]), 0);
        //            } else if ([thisPos isEqualToString:@"top"]) {
        //                CGConfigureDisplayOrigin(config, activeDisplays[i], 0, -1*CGDisplayPixelsHigh(activeDisplays[i]));
        //            } else if ([thisPos isEqualToString:@"bottom"]) {
        //                CGConfigureDisplayOrigin(config, activeDisplays[i], 0, CGDisplayPixelsHigh(activeDisplays[newMainScreenIndex]));
        //            }
        //            othersCount++;
        //        }
        //    }
        //    CGCompleteDisplayConfiguration(config, kCGConfigureForSession);
    }
}
