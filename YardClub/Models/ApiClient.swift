//
//  ApiClient.swift
//  YardClub
//
//  Created by James Craige on 5/29/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Foundation
import ReactiveCocoa

typealias RequestSignalProducer = SignalProducer<(NSData, NSURLResponse), NSError>

class ApiClient: ApiConnectable {
    let apiURL = NSURL(string: "http://yardclub.github.io/mobile-interview/api")!

    var getCategories: Action<Void, [Category], NSError>!

    init() {
        getCategories = Action {
            let categoriesURL = self.apiURL.URLByAppendingPathComponent("catalog.json")
            return self.getRequest(categoriesURL)
                |> map { data, _ in parseJsonArray(data) }
        }
    }

    func getRequest(url: NSURL) -> RequestSignalProducer {
        let request = NSURLRequest(URL: url)
        return NSURLSession.sharedSession().rac_dataWithRequest(request)
    }
}