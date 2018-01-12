//
//  main.swift
//   display-arranger
//
//  Created by Dan Loman on 1/11/18.
//  Copyright © 2018 Daniel Loman. All rights reserved.
//
// requires Mac OS X 10.13 or higher

import Foundation

let arranger: DisplayArranger = .init()

switch ProcessInfo().arguments {
case let args where args.count == 1, let args where args.first == "-h":
    arranger.output(item: .help)
case let args where args[1] == "-info":
    arranger.output(item: .displaysInfo)
case let args where args[1] == "-screenIds":
    arranger.output(item: .screenIds)
case let args where args[1] == "-setMainId":
    guard let mainId = arranger.mainId else {
        fatalError("No mainId set")
    }
    guard let screenPositions = arranger.screenPositions else {
        fatalError("Missing starting position argument")
    }
    do {
        try arranger.setAsMainDisplay(id: mainId, otherPositions: screenPositions)
    } catch {
        print(error.localizedDescription)
    }
default:
    arranger.output(item: .undefined)
}

//} else if ([[pInfo objectAtIndex:1] isEqualToString:@"-setMainID"]) {
//    NSString* screenID = [[NSUserDefaults standardUserDefaults] stringForKey:@"setMainID"];
//    NSString* othersStartingPosition = [[NSUserDefaults standardUserDefaults] stringForKey:@"othersStartingPosition"];
//    setMainScreen(screenID, othersStartingPosition);
