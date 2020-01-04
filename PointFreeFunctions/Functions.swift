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

func compute(_ x: Int) -> Int {
    x * x + 1
}

func computeWithEffect(_ x: Int) -> Int {
    let computation = x * x + 1
    print("Computed \(computation)")
    return computation
}

func computeAndPrint(_ x: Int) -> (Int, [String]) {
    let computation = x * x + 1
    
    return (computation, ["Computed \(computation)"])
}

func compose<A, B, C>(_ f: @escaping (A) -> (B, [String]),
                      _ g: @escaping (B) -> (C, [String])) -> (A) -> (C, [String]) {
    { a in
        let (b, logs) = f(a)
        let (c, moreLogs) = g(b)
        return (c, logs + moreLogs)
    }
}

func uppercased(_ string: String) -> String {
  return string.uppercased()
}

func greetWithEffect(_ name: String) -> String {
    let seconds = Int(Date().timeIntervalSince1970) % 60
    return "Hello \(name)! It's \(seconds) seconds past the minute."
}

func greet(at date: Date, name: String) -> String {
    let seconds = Int(date.timeIntervalSince1970) % 60
    return "Hello \(name)! It's \(seconds) seconds past the minute."
}

func greet(at date: Date) -> (_ name: String) -> String {
    { name in
        let seconds = Int(date.timeIntervalSince1970) % 60
        return "Hello \(name)! It's \(seconds) seconds past the minute."
    }
}

//

struct NumberFormatterConfig {
    
    var numberStyle = NumberFormatter.Style.none
    var roundingMode = NumberFormatter.RoundingMode.up
    var maximumFractionDigits = 0
    
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = numberStyle
        formatter.roundingMode = roundingMode
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.currencySymbol = "$"
        return formatter
    }
}

func decimalStyle(_ format: NumberFormatterConfig) -> NumberFormatterConfig {
    var format = format
    format.numberStyle = .decimal
    format.maximumFractionDigits = 2
    return format
}

func currencyStyle(_ format: NumberFormatterConfig) -> NumberFormatterConfig {
    var format = format
    format.numberStyle = .currency
    format.roundingMode = .down
    return format
}

func wholeStyle(_ format: NumberFormatterConfig) -> NumberFormatterConfig {
    var format = format
    format.maximumFractionDigits = 0
    return format
}

func inoutDecimalStyle(_ format: inout NumberFormatterConfig) -> NumberFormatterConfig {
    format.numberStyle = .decimal
    format.maximumFractionDigits = 2
    return format
}

func inoutCurrencyStyle(_ format: inout NumberFormatterConfig) -> NumberFormatterConfig {
    format.numberStyle = .currency
    format.roundingMode = .down
    return format
}

func inoutWholeStyle(_ format: inout NumberFormatterConfig) -> NumberFormatterConfig {
    format.maximumFractionDigits = 0
    return format
}

func toInout<A>(_ f: @escaping (A) -> A) -> ((_ a: inout A) -> Void) {
    { a in
        a = f(a)
    }
}

func fromInout<A>(_ f: @escaping (_ a: inout A) -> Void) -> ((A) -> A) {
    { a in
        var copy = a
        f(&copy)
        return copy
    }
}
