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
        XCTAssertEqual(2 |> incr |> square, 9)
    }
    
    func testForwardComposeOperator() {
        XCTAssertEqual((square >>> incr)(3), 10)
        XCTAssertEqual(2 |> incr >>> square, 9)
        
        XCTAssertEqual(increaseThenSquare(2), 9)
        
        XCTAssertEqual(2 |> incr >>> square >>> String.init, "9")
        
        let result1 = [1, 2, 3]
            .map(incr)
            .map(square)
        XCTAssertEqual(result1, [4, 9, 16])
        
        let result2 = [1, 2, 3]
            .map(incr >>> square)
        XCTAssertEqual(result2, [4, 9, 16])
    }
    
}
