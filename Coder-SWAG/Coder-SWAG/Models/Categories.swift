//
//  Categories.swift
//  Coder-SWAG
//
//  Created by Nikhil Muskur on 29/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation


struct Categories {
	
	var title: String
	var imageName: String
	
	static func getAllCategories() -> [Categories] {
		let categories = [
			Categories(title: "Hoodies", imageName: "hoodies.png"),
			Categories(title: "Hats", imageName: "hats.png"),
			Categories(title: "T-shirts", imageName: "shirts.png"),
			Categories(title: "Digital Goods", imageName: "digital.png")
		]
		
		return categories
	}
}
