//
//  CurryTests.swift
//  PointFreeFunctionsTests
//
//  Created by 양원석 on 2020/02/03.
//  Copyright © 2020 양원석. All rights reserved.
//

import XCTest
@testable import PointFreeFunctions

class CurryTests: XCTestCase {
    
    func testCurry() {
        // curry
        //greet(at: , name: ) // (Date, String) -> String

        // curried function version
        _ = curry(greet(at:name:)) // (Date) -> (String) -> String

        // manual curred version
        _ = greet(at:)

        // 심지어 UIKit 의 함수들도 커링 가능
        let initWithData = curry(String.init(data: encoding:))
            >>> { $0(.utf8) }
        _ = initWithData(Data())
        
        let stringWithEncoding = flip(curry(String.init(data: encoding:)))
        let utf8String = stringWithEncoding(.utf8)
        _ = utf8String(Data())
    }
    
    func testUnboundMethods() {
        
        let upper = "Hello".uppercased(with: Locale(identifier: "en"))
        XCTAssertEqual(upper, "HELLO")
        
        let uppercased = String.uppercased(with:)("hello")(Locale(identifier: "en"))
        XCTAssertEqual(uppercased, "HELLO")
        
        let uppercasedWithLocale = flip(String.uppercased(with:))
        let uppercasedWithEn = uppercasedWithLocale(Locale(identifier: "en"))
        
        XCTAssertEqual(uppercasedWithEn("hello"), "HELLO")
        
        let result = "hello" |> uppercasedWithEn
        XCTAssertEqual(result, "HELLO")
    }
    
    func testAProblem() {
        let upper = flip(String.uppercased)()
        XCTAssertEqual(upper("hello"), "HELLO")
        
        XCTAssertEqual("hello" |> flip(String.uppercased)(), "HELLO")
    }
    
    func testZurry() {
        let upper = zurry(flip(String.uppercased))
        
        XCTAssertEqual(upper("hello"), "HELLO")
        XCTAssertEqual("hello" |> zurry(flip(String.uppercased)), "HELLO")
    }
    
    func testMap() {
        
        let toStr = map(incr) >>> map(square) >>> map(String.init)
        
        XCTAssertEqual(toStr([1, 2]), ["4", "9"])
        
        let toStr2 = map(incr >>> square >>> String.init)
        
        XCTAssertEqual(toStr2([1, 2]), ["4", "9"])
    }
    
    func testFilter() {
        
        let result = Array(1...10)
            |> filter({ $0 > 5 })
            >>> map(incr >>> square)
        
        XCTAssertEqual(result, [49, 64, 81, 100, 121])
    }
}
