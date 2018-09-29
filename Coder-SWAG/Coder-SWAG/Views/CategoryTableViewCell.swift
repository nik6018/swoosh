//
//  CategoryTableViewCell.swift
//  Coder-SWAG
//
//  Created by Nikhil Muskur on 29/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
	
	@IBOutlet weak var categoryImage: UIImageView!
	@IBOutlet weak var categoryTitle: UILabel!

	func updateCell(withCategory category: Categories) { 
		categoryImage.image = UIImage(named: category.imageName)
		categoryTitle.text = category.title
	}

}
