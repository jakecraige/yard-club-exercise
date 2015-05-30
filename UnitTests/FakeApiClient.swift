//
//  FakeApiClient.swift
//  YardClub
//
//  Created by James Craige on 5/30/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Foundation
import ReactiveCocoa

class FakeApiClient: ApiConnectable {
    lazy var apiURL: NSURL = { undefined("fake apiURL") }()
    var getCategories: Action<Void, [Category], NSError>!
    var categoriesSink: SinkOf<Event<[Category], NSError>>!

    init() {
        let (producer, sink) = SignalProducer<[Category], NSError>.buffer()
        categoriesSink = sink
        getCategories = Action { producer }
    }
}
