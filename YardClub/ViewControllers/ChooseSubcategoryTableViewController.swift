//
//  ChooseSubcategoryTableViewController.swift
//  YardClub
//
//  Created by James Craige on 6/13/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit
import Runes
import ReactiveCocoa

class ChooseSubcategoryTableViewController: UITableViewController {
    var controller: ChooseSubcategoryController?

    override func viewDidLoad() {
        navigationItem.title = controller?.category.name
        controller?.requestSubcategories()

        if let controller = controller {
            controller.subcategories.producer.start(next: { subcategories in
                println("subcategories \(subcategories.count)")
                for s in subcategories {
                    println(s)
                }
            })
        }
    }
}
