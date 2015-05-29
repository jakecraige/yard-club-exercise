//
//  JsonParser.swift
//  YardClub
//
//  Created by James Craige on 5/29/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Foundation
import Runes
import Argo

func parseJsonArray<T: Decodable where T.DecodedType == T>(data: NSData) -> [T] {
    let result: [T] = (jsonFromData(data) >>- decode) ?? []

    return result
}

func parseJson<T: Decodable where T.DecodedType == T>(data: NSData) -> T? {
    let result: T? = jsonFromData(data) >>- decode

    return result
}

func jsonFromData(data: NSData) -> AnyObject? {
    return NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)
}