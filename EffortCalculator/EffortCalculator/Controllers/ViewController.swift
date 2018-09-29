//
//  ViewController.swift
//  EffortCalculator
//
//  Created by Nikhil Muskur on 28/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var calculatedHoursLabel: UILabel! {
		didSet {
			calculatedHoursLabel.isHidden = true
		}
	}
	
	@IBOutlet weak var staticHoursLabel: UILabel! {
		didSet {
			staticHoursLabel.isHidden = true
		}
	}
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var itemPriceTextField: CurrencyTextField!
	@IBOutlet weak var hourlyWagesTextField: CurrencyTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tapGesture)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	@IBAction func calculatedButtonPressed(_ sender: Any) {
		guard let itemPrice = itemPriceTextField.text, let hourlyWages = hourlyWagesTextField.text else {
			clearTextFieldValues()
			return
		}
		
		if let price = Double(itemPrice), let wage = Double(hourlyWages) {
			let hoursRequired = Wage.calculateHours(withWage: wage, forItemPrice: price)
			calculatedHoursLabel.isHidden = false
			calculatedHoursLabel.text = String(hoursRequired)
			staticHoursLabel.isHidden = false
		} else {
			clearTextFieldValues()
		}
	}
	
	@IBAction func clearButtonPressed(_ sender: Any) {
		clearTextFieldValues()
	}
	
	func clearTextFieldValues() {
		itemPriceTextField.text = ""
		hourlyWagesTextField.text = ""
		
		calculatedHoursLabel.isHidden = true
		staticHoursLabel.isHidden = true
	}
	
}

