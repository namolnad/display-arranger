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
let router: ArgumentRouter = .init()

router.route(args: ProcessInfo().arguments, arranger: arranger)
