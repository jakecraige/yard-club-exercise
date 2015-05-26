//
//  ApplicationController.swift
//  YardClub
//
//  Created by James Craige on 5/25/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class ApplicationController {
    let rootViewController: UIViewController

    init() {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        rootViewController = storyboard.instantiateInitialViewController() as! UIViewController
    }
}