//
//  PopularMovieCollectionViewCell.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 13/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class MovieBrowserCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet private weak var imageView: UIImageView!
	static let reuseIdentifier = "PopularCell"
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		//reset the cell
		updateCell(withImage: nil)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		//view initialization
		updateCell(withImage: nil)
	}
	
	func updateCell(withImage image: UIImage?) {
		imageView.image = nil
		imageView.backgroundColor = UIColor.black
		// add code to upadte the cell
		imageView.image = image
	}
}

