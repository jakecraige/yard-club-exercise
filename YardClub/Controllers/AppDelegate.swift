//
//  AppDelegate.swift
//  YardClub
//
//  Created by James Craige on 5/25/15
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var controller: ApplicationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        controller = ApplicationController()

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = controller?.rootViewController
        window?.makeKeyAndVisible()

        let client = ApiClient()
        let x = client.getCategories.apply(nil)

        x.start(error: nil, completed: nil, interrupted: nil, next: { println("done") })

        return true
    }
}
