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

    init(apiClient: ApiConnectable) {
        self.apiClient = apiClient
        self.categories <~ self.apiClient.getCategories.values
    }

    func requestCategories() {
        self.apiClient.getCategories.apply().start()
    }
}