//
//  Wage.swift
//  EffortCalculator
//
//  Created by Nikhil Muskur on 28/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation


class Wage {
	static func calculateHours(withWage wage: Double, forItemPrice itemPrice: Double) -> Int {
		if itemPrice < wage {
			return 1
		} else if wage == 0 || itemPrice == 0 {
			return 0
		} else {
			return Int(ceil(itemPrice / wage))
		}
	}
}
