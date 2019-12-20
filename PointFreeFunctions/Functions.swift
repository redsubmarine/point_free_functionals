//
//  Functions.swift
//  PointFreeFunctions
//
//  Created by 양원석 on 2019/12/20.
//  Copyright © 2019 양원석. All rights reserved.
//

import Foundation

func incr(_ a: Int) -> Int {
    a + 1
}

func square(_ a: Int) -> Int {
    a * a
}

let increaseThenSquare = incr >>> square
