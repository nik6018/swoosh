//
//  ViewController.swift
//  Eluxon
//
//  Created by Nikhil Muskur on 27/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var onOffLabel: UILabel!
	@IBOutlet weak var toggleButton: UIButton!
	
	var switchStatus = SwitchStatus.off {
		didSet {
			switch switchStatus {
			case .on:
				onOffLabel.text = "🌝 ON 🌝"
				view.backgroundColor = .white
				onOffLabel.textColor = .black
				toggleButton.setTitleColor(.black, for: .normal)
			case .off:
				onOffLabel.text = "🌚 OFF 🌚"
				view.backgroundColor = #colorLiteral(red: 0.3869170368, green: 0.3869170368, blue: 0.3869170368, alpha: 1)
				onOffLabel.textColor = .white
				toggleButton.setTitleColor(.white, for: .normal)
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	@IBAction func toggleButtonPressed(_ sender: Any) {
		switchStatus.toggle()
	}
	
}

protocol Togglable {
	mutating func toggle()
}

enum SwitchStatus: Togglable {
	case on, off
	
	mutating func toggle() {
		switch self {
		case .on:
			self = .off
		case .off:
			self = .on
		}
	}
}

