//
//  ChooseCategoryTableViewController.swift
//  YardClub
//
//  Created by James Craige on 5/25/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ChooseCategoryTableViewController: UITableViewController {
    var storeType: String?
    var controller: ChooseCategoryController?
    var categories: [Category] {
        get { return controller?.categories.value ?? [] }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = BasicTableViewCell.Constants.rowHeight
        tableView.estimatedRowHeight = BasicTableViewCell.Constants.estimatedRowHeight
        let tableCellNib = UINib(nibName: "BasicTableViewCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(tableCellNib, forCellReuseIdentifier: BasicTableViewCell.Constants.ReuseIdentifier)
        refreshControl = UIRefreshControl()

        if let ctrl = controller {
            let newCategories = ctrl.categories.producer |> observeOn(UIScheduler())

            ctrl.refreshBegan |> start(next: { _ in self.refreshControl?.beginRefreshing() })
            ctrl.refreshEnded |> start(next: { _ in self.refreshControl?.endRefreshing() })
            newCategories |> start(next: { _ in self.tableView.reloadData() })

            ctrl.requestCategories()
        }
    }
}

extension ChooseCategoryTableViewController: UITableViewDataSource {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BasicTableViewCell.Constants.ReuseIdentifier) as! BasicTableViewCell
        return cell;
    }
}

extension ChooseCategoryTableViewController: UITableViewDelegate {
    struct Constants {
        static let HeaderViewHeight: CGFloat = 36
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constants.HeaderViewHeight))
        headerView.backgroundColor = UIColor(rgba: "#f2f2f2")

        let label = UILabel(frame: CGRect(x: 10, y: 0, width: headerView.frame.width - 10, height: Constants.HeaderViewHeight))
        label.text = "What kind of equipment are you looking for?"
        label.font = UIFont.boldSystemFontOfSize(12)

        headerView.addSubview(label)
        return headerView
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.HeaderViewHeight
    }
}
