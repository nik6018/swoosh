//
//  CurrencyTextField.swift
//  EffortCalculator
//
//  Created by Nikhil Muskur on 28/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

@IBDesignable
class CurrencyTextField: UITextField {
	
	override func draw(_ rect: CGRect) {
		let size : CGFloat = 20
		let labelPosition = CGRect(x: 15, y: (frame.size.height / 2) - (size / 2) , width: size, height: size)
		let currencySymbolLabel = UILabel(frame: labelPosition)
		currencySymbolLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.8465860445)
		currencySymbolLabel.textAlignment = .center
		currencySymbolLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
		currencySymbolLabel.layer.cornerRadius = 2.0
		currencySymbolLabel.clipsToBounds = true
		
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = .current
		currencySymbolLabel.text = formatter.currencySymbol
		addSubview(currencySymbolLabel)
	}
	
	
	override func prepareForInterfaceBuilder() {
		setUpButton()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setUpButton()
	}

	func setUpButton() {
		backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2470836901)
		textColor = UIColor.white
		textAlignment = .center
		
		if let pText = placeholder {
			let attributedString = NSAttributedString(string: pText, attributes: [.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) ])
			attributedPlaceholder = attributedString
		}
		
	}
}
