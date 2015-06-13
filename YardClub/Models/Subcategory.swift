//
//  Subcategory.swift
//  YardClub
//
//  Created by James Craige on 6/13/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Foundation
import Runes
import Argo

struct Subcategory {
    var id: Int
    var detail: String
    var displayName: String
}

extension Subcategory: Decodable {
    static func create(id: Int)(detail: String)(displayName: String) -> Subcategory {
        return Subcategory(id: id, detail: detail, displayName: displayName)
    }

    static func decode(json: JSON) -> Decoded<Subcategory> {
        return Subcategory.create
            <^> json <| "id"
            <*> json <| "detail"
            <*> json <| "display_name"
    }
}

extension Subcategory: Printable {
    var description: String {
        return "Subcategory - id: \(id), detail: \(detail), displayName: \(displayName)"
    }
}

extension Subcategory: Equatable { }

func == (lhs: Subcategory, rhs: Subcategory) -> Bool {
    return lhs.id == rhs.id
}