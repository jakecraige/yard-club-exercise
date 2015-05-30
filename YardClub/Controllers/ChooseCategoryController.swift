//
//  ChooseCategoryController.swift
//  YardClub
//
//  Created by James Craige on 5/30/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import ReactiveCocoa

class ChooseCategoryController {
    let apiClient: ApiConnectable

    var categories: MutableProperty<[Category]> = MutableProperty([])

    var refreshing: SignalProducer<Bool, NoError> {
        get {
            return apiClient.getCategories.executing.producer |> throttle(0.75, onScheduler: QueueScheduler.mainQueueScheduler)
        }
    }

    var refreshBegan: SignalProducer<Bool, NoError> {
        get { return refreshing |> filter({ $0 == true }) }
    }

    var refreshEnded: SignalProducer<Bool, NoError> {
        get { return refreshing |> filter({ $0 == false }) }
    }

    init(apiClient: ApiConnectable) {
        self.apiClient = apiClient
        self.categories <~ self.apiClient.getCategories.values
    }

    func requestCategories() {
        self.apiClient.getCategories.apply().start()
    }
}