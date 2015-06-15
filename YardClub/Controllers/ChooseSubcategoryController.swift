//
//  ChooseSubcategoryController.swift
//  YardClub
//
//  Created by James Craige on 6/13/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import ReactiveCocoa

class ChooseSubcategoryController {
    let apiClient: ApiConnectable
    let category: Category
    var subcategories: MutableProperty<[Subcategory]> = MutableProperty([])
    let request: SignalProducer<[Subcategory], NSError>

    init(apiClient: ApiConnectable, category: Category) {
        self.apiClient = apiClient
        self.category = category
        self.request = apiClient.getSubcategoriesForCategory(category)
    }

    func requestSubcategories() {
        // You can only use the <~ operator with a SignalProducer that produces
        // an error of type NoError
        let noErrorRequest = request |> catch { _ in SignalProducer<[Subcategory], NoError>(value: []) }
        subcategories <~ noErrorRequest
    }
}