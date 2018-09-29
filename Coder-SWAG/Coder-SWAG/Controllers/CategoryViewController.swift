//
//  ViewController.swift
//  Coder-SWAG
//
//  Created by Nikhil Muskur on 29/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	lazy var categoryList = Categories.getAllCategories()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		tableView.delegate = self
		tableView.dataSource = self
		
		let backBarButton = UIBarButtonItem()
		backBarButton.title = " "
		navigationItem.backBarButtonItem = backBarButton
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destinationVC = segue.destination as? ProductViewController {
			if let categoryToDisplay = sender as? Categories {
				var categorySelected: CategoryType?
				
				switch categoryToDisplay.title {
				case "Hoodies":
					categorySelected = CategoryType.hoodie
				case "Hats":
					categorySelected = CategoryType.hat
				case "T-shirts":
					categorySelected = CategoryType.tshirt
				case "Digital Goods":
					categorySelected = CategoryType.digital
				default:
					categorySelected = nil
					break
				}
				
				destinationVC.setupProducts(withCategory: categorySelected)
				
			}
		}
	}

}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoryList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
		
		let category = categoryList[indexPath.row]
		cell.updateCell(withCategory: category)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let category = categoryList[indexPath.row]
		performSegue(withIdentifier: "ProductSegue", sender: category)
	}
}







