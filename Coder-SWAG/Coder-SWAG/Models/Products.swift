//
//  Products.swift
//  Coder-SWAG
//
//  Created by Nikhil Muskur on 29/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation

enum CategoryType: String {
	case hoodie
	case hat
	case tshirt
	case digital
}


struct Products {
	var title: String
	var price: String
	var imageName: String
	
	static func getAllHoodies() -> [Products] {
		let products = [
			Products(title: "Devslopes Hoodie One", price: "$25", imageName: "hoodie01"),
			Products(title: "Devslopes Hoodie Two", price: "$35", imageName: "hoodie02"),
			Products(title: "Devslopes Hoodie Three", price: "$20", imageName: "hoodie03"),
			Products(title: "Devslopes Hoodie Four", price: "$40", imageName: "hoodie04")
		]
		
		return products
	}
	
	static func getAllHats() -> [Products] {
		let products = [
			Products(title: "Devslopes Hats One", price: "$25", imageName: "hat01"),
			Products(title: "Devslopes Hats Two", price: "$35", imageName: "hat02"),
			Products(title: "Devslopes Hats Three", price: "$20", imageName: "hat03"),
			Products(title: "Devslopes Hats Four", price: "$40", imageName: "hat04")
		]
		
		return products
	}
	
	static func getAllTshirts() -> [Products] {
		let products = [
			Products(title: "Devslopes T-Shirt One", price: "$25", imageName: "shirt01"),
			Products(title: "Devslopes T-Shirt Two", price: "$35", imageName: "shirt02"),
			Products(title: "Devslopes T-Shirt Three", price: "$20", imageName: "shirt03"),
			Products(title: "Devslopes T-Shirt Four", price: "$40", imageName: "shirt04")
		]
		
		return products
	}
	
	static func getAllDigitalGoodies() -> [Products] {
		let products = [
			Products(title: "Devslopes Digital Goods One", price: "$25", imageName: "hoodie01"),
			Products(title: "Devslopes Digital Goods Two", price: "$35", imageName: "hoodie02"),
			Products(title: "Devslopes Digital Goods Three", price: "$20", imageName: "hoodie03"),
			Products(title: "Devslopes Digital Goods Four", price: "$40", imageName: "hoodie04")
		]
		
		return products
	}
}
