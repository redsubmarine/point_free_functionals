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
    
    func testSideEffect() {
        XCTAssertEqual(compute(2), 5)
        XCTAssertEqual(computeWithEffect(2), 5)
        
        XCTAssertEqual([2, 10].map(compute).map(compute), [26, 10202])
        XCTAssertEqual([2, 10].map(compute >>> compute), [26, 10202])
        
        XCTAssertEqual([2, 10].map(computeWithEffect).map(computeWithEffect), [26, 10202])
        XCTAssertEqual([2, 10].map(computeWithEffect >>> computeWithEffect), [26, 10202])
        
        let (result, texts) = computeAndPrint(2)
        XCTAssertEqual(result, 5)
        XCTAssertEqual(texts, ["Computed 5"])
        
        let (res1, logs1) = (compose(computeAndPrint, computeAndPrint))(2)
        
        XCTAssertEqual(res1, 26)
        XCTAssertEqual(logs1, ["Computed 5", "Computed 26"])
        
        let (res2, logs2) = 2 |> compose(computeAndPrint, computeAndPrint)
        
        XCTAssertEqual(res2, 26)
        XCTAssertEqual(logs2, ["Computed 5", "Computed 26"])
    }
    
    func testComposeMore3() {
        let fun = computeAndPrint
            >=> computeAndPrint
            >=> computeAndPrint
        
        XCTAssertNotNil(fun)
        
        let moreFun = 2 |> computeAndPrint
            >=> computeAndPrint
            >=> computeAndPrint
        XCTAssertNotNil(moreFun)
        
        let moreMoreFun = 2 |> computeAndPrint
            >=> (incr >>> computeAndPrint)
            >=> (incr >>> computeAndPrint)
        XCTAssertNotNil(moreMoreFun)
        
        let moreMoreMoreFun = 2 |> computeAndPrint
            >=> incr >>> computeAndPrint
            >=> incr >>> computeAndPrint
        XCTAssertNotNil(moreMoreMoreFun)
    }
    
    
    func testFunctionWithSideEffect() {
        // maybe fail always..
        XCTAssertNotEqual(
            "Hello Blob! It's 1 seconds past the minute.",
            greetWithEffect("Blob")
        )
        
        // so change the function to this.
        // now I can control the date and have a test that always passes!
        XCTAssertEqual(
            "Hello Blob! It's 23 seconds past the minute.",
            greet(at: Date(timeIntervalSince1970: 23), name: "Blob")
        )
        //but! cannot compose
        
        let a = "Blob" |> uppercased
            >>> greetWithEffect
        XCTAssertNotNil(a)
        
        // cannot compile
//        let b = "Blob" |> uppercased
//            >>> greet
        
        // now I can compose
        XCTAssertEqual(
            "Blob" |> greet(at: Date(timeIntervalSince1970: 33))
            >>> uppercased,
            
            "HELLO BLOB! IT'S 33 SECONDS PAST THE MINUTE."
        )
        
        XCTAssertEqual(
            "Blob" |> uppercased
            >>> greet(at: Date(timeIntervalSince1970: 33)),
            
            "Hello BLOB! It's 33 seconds past the minute."
        )
    }
    
    func testMutation() {
        var config = NumberFormatterConfig()
        
        XCTAssertEqual(
            inoutCurrencyStyle(&config).formatter
                .string(from: 1234.6),
            "$1,234"
        )
//        XCTAssertEqual(
//            inoutWholeStyle(&inoutDecimalStyle(&config)).formatter
//                .string(from: 1234.6),
//            "1,235"
//        )
        XCTAssertNotNil(decimalStyle >>> currencyStyle)
        XCTAssertNotNil(currencyStyle >>> decimalStyle)
        
        // inout functions cannot this
        // so we need bridge for this
        
        XCTAssertNotNil(config |> decimalStyle <> currencyStyle)
//        XCTAssertNotNil(config |> inoutDecimalStyle <> inoutCurrencyStyle)
//        XCTAssertNotNil(inoutDecimalStyle <> currencyStyle)
    }
    
}
