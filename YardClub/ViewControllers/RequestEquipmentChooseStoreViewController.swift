//
//  RequestEquipmentChooseStoreViewController.swift
//  YardClub
//
//  Created by James Craige on 5/25/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit
import Runes

class RequestEquipmentChooseStoreViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!

    var controller: ApplicationController?

    weak var pageViewController: UIPageViewController? {
        didSet {
            pageViewController?.delegate = self
            pageViewController?.dataSource = self
            if let initialVC = viewControllerAtIndex(0) {
                pageViewController?.setViewControllers([initialVC], direction: .Forward, animated: false, completion: nil)
                pageControl.currentPage = 0
            }
        }
    }

    var featuredEquipmentList = [1, 2, 3, 4] {
        didSet {
            pageControl.numberOfPages = featuredEquipmentList.count
        }
    }

    private struct Constants {
        static let PageVCEmbedIdentifier = "PageVCEmbed"
        static let PageContentVCIdentifier = "FeaturedEquipmentPageContentVC"
        static let ChooseCatalogIdentifier = "ShowChooseCatalog"
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.PageVCEmbedIdentifier:
                pageViewController = segue.destinationViewController as? UIPageViewController
            case Constants.ChooseCatalogIdentifier:
                let vc = segue.destinationViewController as? ChooseCategoryTableViewController
                vc?.storeType = sender as? String
                vc?.controller = controller?.chooseCategoryController
                vc?.navigationItem.title = vc?.storeType
            default: break
            }
        }
    }

    private struct StoreType {
        static let Rental = "rental"
        static let Contractor = "contractor"
    }

    @IBAction func chooseRentalStore(sender: UIButton) {
        performSegueWithIdentifier(Constants.ChooseCatalogIdentifier, sender: StoreType.Rental)
    }

    @IBAction func chooseContractor(sender: UIButton) {
        performSegueWithIdentifier(Constants.ChooseCatalogIdentifier, sender: StoreType.Contractor)
    }
}


extension RequestEquipmentChooseStoreViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
         let index = (viewController as? FeaturedEquipmentContentViewController)?.pageIndex

        return index <^> { $0 - 1 } >>- { self.viewControllerAtIndex($0) }
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = (viewController as? FeaturedEquipmentContentViewController)?.pageIndex

        return index <^> { $0 + 1 } >>- { self.viewControllerAtIndex($0) }
    }

    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if (index < 0 || index >= featuredEquipmentList.count) {
            return nil
        }

        let vc = storyboard?.instantiateViewControllerWithIdentifier(Constants.PageContentVCIdentifier) as? FeaturedEquipmentContentViewController
        vc?.pageIndex = index

        return vc
    }
}

extension RequestEquipmentChooseStoreViewController: UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        if (!completed) { return }

        if let index = (pageViewController.viewControllers.last as? FeaturedEquipmentContentViewController)?.pageIndex {
            pageControl.currentPage = index
        }
    }
}