//
//  ChooseCategoryTableViewController.swift
//  YardClub
//
//  Created by James Craige on 5/25/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class ChooseCategoryTableViewController: UITableViewController {
    var storeType: String?
    var catalogs: [Int] = [1,3,4,5]
    var controller: ChooseCategoryController?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = BasicTableViewCell.Constants.rowHeight
        tableView.estimatedRowHeight = BasicTableViewCell.Constants.estimatedRowHeight
        let tableCellNib = UINib(nibName: "BasicTableViewCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(tableCellNib, forCellReuseIdentifier: BasicTableViewCell.Constants.ReuseIdentifier)
    }
}

extension ChooseCategoryTableViewController: UITableViewDataSource {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogs.count
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
