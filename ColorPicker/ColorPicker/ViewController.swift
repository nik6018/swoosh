//
//  ViewController.swift
//  ColorPicker
//
//  Created by Nikhil Muskur on 26/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ColorPicker {

	@IBOutlet var backgroundView: UIView!
	@IBOutlet weak var colorNameLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == SegueIdentifier.ColorPicker.rawValue {
			if let colorPickerViewController = segue.destination as? ColorPickerViewController {
				colorPickerViewController.delegate = self
			}
		}
	}
	
	func setBackground(with color: UIColor, with name: String) {
		changeNavigationBarAppearence(with: color)
		backgroundView.backgroundColor = color
		colorNameLabel.text = name
	}
	
	func changeNavigationBarAppearence(with color: UIColor) {
		// IMP Remember
		navigationItem.rightBarButtonItem?.tintColor = color
		navigationController?.navigationBar.tintColor = color
		navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: color]
	}
}

enum SegueIdentifier: String {
	case ColorPicker = "ColorPicker"
}
