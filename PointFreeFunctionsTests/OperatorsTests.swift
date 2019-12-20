//
//  OperatorsTests.swift
//  PointFreeFunctionsTests
//
//  Created by 양원석 on 2019/12/20.
//  Copyright © 2019 양원석. All rights reserved.
//

import XCTest
@testable import PointFreeFunctions

class OperatorsTests: XCTestCase {
    
    func testPipeOperator() {
        XCTAssertEqual(2 |> incr, 3)
        XCTAssertEqual(((2 |> incr) |> incr) |> incr, 5)
        XCTAssertEqual(2 |> incr |> incr |> incr, 5)
    }
    
}
