//
//  DetailRatingTableViewCell.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 16/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class DetailRatingTableViewCell: UITableViewCell {
	
	@IBOutlet private weak var rating: UILabel!
	@IBOutlet private weak var numberOfVotes: UILabel!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		rating.text = "Rating: 0.0"
		numberOfVotes.text = "0 Votes"
    }
	
	func updateRating(_ ratingForTheMovie: String, _ votes: String) {
		if let _ = rating, let _ = numberOfVotes {
			rating.text = "Rating : \(ratingForTheMovie)"
			numberOfVotes.text = "\(votes) Votes"
		}
	}
}
