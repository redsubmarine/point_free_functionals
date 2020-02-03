//
//  Curry.swift
//  PointFreeFunctions
//
//  Created by 양원석 on 2020/02/03.
//  Copyright © 2020 양원석. All rights reserved.
//

import Foundation

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    { a in
        { b in
            f(a, b)
        }
    }
}

func flip<A, B, C>( _ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    { b in
        { a in
            f(a)(b)
        }
    }
}

func flip<A, C>(_ f: @escaping (A) -> () -> C) -> () -> (A) -> C {
    {
        { f($0)() }
    }
}

func zurry<A>(_ f: @escaping () -> A) -> A {
    f()
}

func map<A, B>(_ f: @escaping (A) -> B) -> ([A]) -> [B] {
    {
        $0.map(f)
    }
}

func filter<A>(_ f: @escaping (A) -> Bool) -> ([A]) -> [A] {
    {
        $0.filter(f)
    }
}
