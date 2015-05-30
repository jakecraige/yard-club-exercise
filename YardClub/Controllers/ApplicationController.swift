//
//  ApplicationController.swift
//  YardClub
//
//  Created by James Craige on 5/25/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ApplicationController {
    var rootViewController: UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateInitialViewController() as! UIViewController
        return vc
    }

    let apiClient = ApiClient()

    func printAllCategories() {
        apiClient.getCategories.apply().start()
        apiClient.getCategories.values
            |> observe(next: { println($0) })
    }
}