//
//  ViewController.swift
//  swoosh
//
//  Created by Nikhil Muskur on 27/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

	@IBOutlet weak var homeBackgroundImage: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	@IBAction func unwindSegueFromLegueVC(unwindSegue: UIStoryboardSegue) {
		print("Unwind Segue Triggered")
	}
}

