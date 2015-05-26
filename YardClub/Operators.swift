//
//  Operators.swift
//  YardClub
//
//  Created by James Craige on 5/25/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Runes

public func <^><T, U>(a: T?, @noescape f: T -> U) -> U? {
    return a.map(f)
}
