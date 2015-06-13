//
//  ApiConnectable.swift
//  YardClub
//
//  Created by James Craige on 5/30/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Foundation
import ReactiveCocoa

protocol ApiConnectable {
    var apiURL: NSURL { get }
    var getCategories: Action<Void, [Category], NSError>! { get set }

    func getSubcategoriesForCategory(category: Category) -> SignalProducer<[Subcategory], NSError>
}