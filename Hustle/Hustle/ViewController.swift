//
//  ViewController.swift
//  Hustle
//
//  Created by Nikhil Muskur on 18/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

	private var player: AVAudioPlayer!
	
	@IBOutlet private weak var darkBlueImage: UIImageView!
	@IBOutlet private weak var onButton: UIButton!
	@IBOutlet private weak var blueView: UIView!
	@IBOutlet private weak var rocketImage: UIImageView!
	@IBOutlet private weak var cloudImage: UIImageView!
	@IBOutlet private weak var hustleLabel: UILabel!
	@IBOutlet private weak var indicatorLabel: UILabel!
	
	private var toggleInitialUI: Bool! {
		didSet {
			darkBlueImage.isHidden = toggleInitialUI
			onButton.isHidden = toggleInitialUI
		}
	}
	
	private var toggleAnimationUI: Bool! {
		didSet {
			blueView.isHidden = toggleAnimationUI
			rocketImage.isHidden = toggleAnimationUI
			cloudImage.isHidden = toggleAnimationUI
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		toggleInitialUI = false
		toggleAnimationUI = true
		
		if let path = Bundle.main.path(forResource: "hustle-on", ofType: "wav") {
			let audioURL = URL(fileURLWithPath: path)
			
			do {
				player = try AVAudioPlayer(contentsOf: audioURL)
				player.prepareToPlay()
			} catch {
				print("Unable load the Audio Player with the provided URL with err: \(error)")
			}
		}
	}
	
	@IBAction private func onButtonPressed(_ sender: Any) {
		toggleInitialUI = true
		toggleAnimationUI = false
		
		player.play()
		
		UIViewPropertyAnimator.runningPropertyAnimator(
			withDuration: 2.0,
			delay: 0,
			options: .curveEaseInOut,
			animations: {
				// Move the Image View frame
				let rocketImg = self.rocketImage!
				rocketImg.frame = CGRect(
					x: 0,
					y: 200,
					width: rocketImg.frame.size.width,
					height: rocketImg.frame.size.height)
		}) { (position) in
			self.hustleLabel.isHidden = false
			self.indicatorLabel.isHidden = false
		}
	}
	
}

