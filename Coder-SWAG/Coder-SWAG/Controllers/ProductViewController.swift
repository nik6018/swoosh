//
//  ProductViewController.swift
//  Coder-SWAG
//
//  Created by Nikhil Muskur on 29/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

	var productCategory = [Products]()
	@IBOutlet weak var collectionView: UICollectionView!
	
	func setupProducts(withCategory category: CategoryType?) {
		
		print("\(#function)")
		
		if let type = category {
			switch type {
			case .hoodie:
				productCategory = Products.getAllHoodies()
				navigationItem.title = "Hoodies"
			case .tshirt:
				productCategory = Products.getAllTshirts()
				navigationItem.title = "T-Shirts"
			case .hat:
				productCategory = Products.getAllHats()
				navigationItem.title = "Hats"
			case .digital:
				productCategory = Products.getAllDigitalGoodies()
				navigationItem.title = "Digital Goods"
			}
		}
		
		print("Item Count: \(productCategory.count)")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		collectionView.delegate = self
		collectionView.dataSource = self
    }
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return productCategory.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! ProductCollectionViewCell
		
		let product = productCategory[indexPath.row]
		cell.updateCell(withProduct: product)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		
		return UIEdgeInsets(
			top: 0,
			left: 0,
			bottom: 0,
			right: 0)
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let width = (collectionView.frame.width / 2) - 1
		let height = 2 * width
		return CGSize(width: width, height: height)
		
	}
	
}
