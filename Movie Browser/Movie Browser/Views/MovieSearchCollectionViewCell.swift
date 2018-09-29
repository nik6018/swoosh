//
//  SearchMovieCollectionViewCell.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 13/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class MovieSearchCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var title: UILabel!
	@IBOutlet private weak var rating: UILabel!
	@IBOutlet private weak var statusImage: UIImageView!
	
	static let reuseIdentifier = "SearchCell"
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		// default setup
		updateCell(withImage: nil, withTitle: nil, withRating: nil)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		// default setup
		updateCell(withImage: nil, withTitle: nil, withRating: nil)
	}
	
	func updateCell(
			withImage image: UIImage?,
			withTitle movieTitle: String?,
			withRating movieRating: Double?) {
		
		imageView.image = nil
		statusImage.image = nil
		imageView.backgroundColor = UIColor.black
		title.text = "No Title"
		rating.text = "No Rating"
		
		// add code to upadte the cell
		if let posterImage = image {
			imageView.image = posterImage
		}
		
		if let movieTitle = movieTitle {
			title.text = movieTitle
		}

		if let movieRating = movieRating {
			let percentage = (Float(movieRating) / 10) * 100
			// if the movie percentage is greater that 60% means people like it.
			if percentage > 60 {
				statusImage.image = #imageLiteral(resourceName: "like")
			} else {
				statusImage.image = #imageLiteral(resourceName: "dislike")
			}
			rating.text = String(percentage)+"%"
		}
	}
}
