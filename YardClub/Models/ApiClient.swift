//
//  ApiClient.swift
//  YardClub
//
//  Created by James Craige on 5/29/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Foundation
import Runes
import Argo

class ApiClient {
    let apiURL = NSURL(string: "http://yardclub.github.io/mobile-interview/api")!

    func getCategories() {
        let categoriesURL = apiURL.URLByAppendingPathComponent("catalog.json")
        let task = NSURLSession.sharedSession().dataTaskWithURL(categoriesURL) { (data, response, error) in
            var categories: [Category] = parseJsonArray(data)
            for cat in categories {
                println(cat)
            }
        }
        task.resume()
    }
}