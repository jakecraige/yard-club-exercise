//
//  Category.swift
//  YardClub
//
//  Created by James Craige on 5/29/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Foundation
import Runes
import Argo

struct Category {
    var id: Int
    var name: String
}

extension Category: Decodable {
    static func create(id: Int)(name: String) -> Category {
        return Category(id: id, name: name)
    }

    static func decode(json: JSON) -> Decoded<Category> {
        return Category.create
            <^> json <| "id"
            <*> json <| "name"
    }
}

extension Category: Printable {
    var description: String {
        return "Category - id: \(id), name: \(name)"
    }
}
