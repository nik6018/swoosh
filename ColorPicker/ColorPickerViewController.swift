//
//  ColorPickerViewController.swift
//  ColorPicker
//
//  Created by Nikhil Muskur on 26/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

protocol ColorPicker {
	func setBackground(with color: UIColor, with name: String)
}

class ColorPickerViewController: UIViewController {

	var delegate: ColorPicker?
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		navigationItem.largeTitleDisplayMode = .never
    }
	
	@IBAction func colorSelectorButtonPressed(_ sender: Any) {
		if let coloredButton = sender as? UIButton {
			delegate?.setBackground(with: coloredButton.backgroundColor!, with: coloredButton.currentTitle!)
		}
		navigationController?.popToRootViewController(animated: true)
	}
	
}
