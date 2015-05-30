//
//  ChooseCategoryControllerSpec.swift
//  YardClub
//
//  Created by James Craige on 5/30/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Quick
import Nimble
import ReactiveCocoa

class ChooseCategoryControllerSpec: QuickSpec {
    override func spec() {
        describe(".categories") {
            it("is bound to the apiClient.getCategories.values") {
                let client = FakeApiClient()
                let controller = ChooseCategoryController(apiClient: client)
                let category = Category(id: 0, name: "FakeCategory")

                expect(controller.categories.value).to(beEmpty())

                controller.requestCategories()
                sendNext(client.categoriesSink, [category])

                expect(controller.categories.value).toEventuallyNot(beEmpty())
            }
        }

        describe("categoryForIndexPath") {
            it("returns the correct category") {
                let client = FakeApiClient()
                let controller = ChooseCategoryController(apiClient: client)
                let category = Category(id: 0, name: "FakeCategory")
                let indexPath = NSIndexPath(forRow: 0, inSection: 0)

                expect(controller.categories.value).to(beEmpty())

                controller.requestCategories()
                sendNext(client.categoriesSink, [category])

                let categoryAtIndexPath = controller.categoryForIndexPath(indexPath)

                expect(categoryAtIndexPath) == category
            }
        }
    }
}