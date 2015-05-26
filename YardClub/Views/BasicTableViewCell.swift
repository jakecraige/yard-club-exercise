//
//  BasicTableViewCell.swift
//  YardClub
//
//  Created by James Craige on 5/25/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImage: UIImageView!

    struct Constants {
        static let estimatedRowHeight: CGFloat = 44
        static let rowHeight: CGFloat = 44
        static let ReuseIdentifier = "BasicTableCellReuse"
    }

    override var layoutMargins: UIEdgeInsets {
        get { return UIEdgeInsetsZero }
        set(newVal) {}
    }
}
