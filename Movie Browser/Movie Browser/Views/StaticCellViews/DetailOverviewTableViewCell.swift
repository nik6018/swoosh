//
//  DetailOverviewTableViewCell.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 16/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class DetailOverviewTableViewCell: UITableViewCell {

	@IBOutlet private weak var overView: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		overView.text = "No OverView"
    }
	
	func updateOverView(_ summary: String) {
		if let _ = overView {
			overView.text = summary
		}
	}
}
