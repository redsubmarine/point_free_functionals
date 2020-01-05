//
//  Operators.swift
//  PointFreeFunctions
//
//  Created by 양원석 on 2019/12/20.
//  Copyright © 2019 양원석. All rights reserved.
//

import Foundation

precedencegroup ForwardApplication {
    associativity: left
}

infix operator |>: ForwardApplication

func |> <A, B>(a: A, f: (A) -> B) -> B {
    f(a)
}

func |> <A>(a: inout A, f: (inout A) -> Void) -> Void {
    f(&a)
}

precedencegroup ForwardComposition {
    associativity: left
    higherThan: EffectfulComposition
}

infix operator >>>: ForwardComposition

func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C) {
    { g(f($0)) }
}

precedencegroup EffectfulComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator >=>: EffectfulComposition

func >=> <A, B, C>(
    _ f: @escaping (A) -> (B, [String]),
    _ g: @escaping (B) -> (C, [String])
    ) -> (A) -> (C, [String]) {
    { a in
        let (b, logs) = f(a)
        let (c, moreLogs) = g(b)
        return (c, logs + moreLogs)
    }
}

precedencegroup SingleTypeComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator <>: SingleTypeComposition

func <> <A>(
    f: @escaping (A) -> A,
    g: @escaping (A) -> A
) -> ((A) -> A) {
    f >>> g
}

func <> <A>(
    f: @escaping (inout A) -> Void,
    g: @escaping (inout A) -> Void
) -> ((inout A) -> Void) {
    { a in
        f(&a)
        g(&a)
    }
}

func <> <A: AnyObject>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> ((A) -> Void) {
    { a in
        f(a)
        g(a)
    }
}
