//
//  DetailTitleTableViewCell.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 16/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class DetailTitleTableViewCell: UITableViewCell {

	@IBOutlet private weak var movieTitle: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		movieTitle.text = "No Title"
    }
	
	func updateTitle(_ title: String) {
		if let _ = movieTitle {
			movieTitle.text = title
		}
	}
}
