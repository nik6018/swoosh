//
//  ViewController.swift
//  ButtonExtension
//
//  Created by Nikhil Muskur on 23/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	
	@IBOutlet weak var wiggleButton: UIButton!
	@IBAction func wiggleButtonPressed(_ sender: Any) {
		wiggleButton.showRandomColor()
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
}

extension UIButton {
	func wiggle() {
		
		let wiggleAnimation = CABasicAnimation(keyPath: "position")
		wiggleAnimation.duration = 0.10
		wiggleAnimation.repeatCount = 3
		wiggleAnimation.autoreverses = true
		wiggleAnimation.fromValue = CGPoint(x: self.center.x - 5, y: self.center.y)
		wiggleAnimation.toValue = CGPoint(x: self.center.x + 5, y: self.center.y)
		layer.add(wiggleAnimation, forKey: "position")
		
	}
	
	func fade() {
		let fadeAnimation = CABasicAnimation(keyPath: "opacity")
		fadeAnimation.duration = 0.27
		fadeAnimation.toValue = 0.5
		fadeAnimation.autoreverses = true
//		layer.add(fadeAnimation, forKey: "opacity")
		
		let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
		cornerRadiusAnimation.duration = 2.0
		cornerRadiusAnimation.toValue = frame.width / 4
		cornerRadiusAnimation.autoreverses = true
		layer.add(cornerRadiusAnimation, forKey: "cornerRadius")
	}
	
	func showRandomColor() {
		let randomColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
		randomColorAnimation.duration = 1.0
		randomColorAnimation.toValue = UIColor.darkGray.cgColor
		randomColorAnimation.autoreverses = true
		layer.add(randomColorAnimation, forKey: "backgroundColor")
	}
}
