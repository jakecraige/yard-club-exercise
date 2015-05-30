//
//  ApiClient.swift
//  YardClub
//
//  Created by James Craige on 5/29/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Foundation
import Runes
import ReactiveCocoa

class ApiClient {
    let apiURL = NSURL(string: "http://yardclub.github.io/mobile-interview/api")!

    let getCategories: Action<AnyObject?, [Category], NSError>

    init() {
        getCategories = Action {
            let categoriesURL = apiURL.URLByAppendingPathComponent("catalog.json")
            let request = NSURLRequest(URL: categoriesURL)
            return NSURLSession.sharedSession().rac_dataWithRequest(request)
                |> map { data, _ in
                    var categories: [Category] = parseJsonArray(data)
                    return categories
            }
        }
    }
}