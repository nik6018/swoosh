//
//  ProductCollectionViewCell.swift
//  Coder-SWAG
//
//  Created by Nikhil Muskur on 29/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var price: UILabel!
	
	func updateCell(withProduct product: Products) {
		imageView.image = UIImage(named: product.imageName)
		title.text = product.title
		price.text = product.price
	}
	
}
