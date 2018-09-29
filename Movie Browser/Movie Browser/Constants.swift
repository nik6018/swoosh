//
//  Constants.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 15/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

struct MovieBrowserConstants {
	static let widthToHeightRatioForListCell: CGFloat = 0.58
	static let leftEdgeInset   : CGFloat = 0
	static let rightEdgeInset  : CGFloat = 0
	static let topEdgeInset    : CGFloat = 0.5
	static let bottomEdgeInset : CGFloat = 0.5
	static let numberOfRows: CGFloat = 3
	static let downloadImageWithWidth: String = "300"
	static let detailSegueIdentifier = "MovieDetail"
}

struct MovieSearchConstants {
	static var widthToHeightRatioForSearchCell: CGFloat {
		if DeviceProperties.isLandscape {
			return 0.3
		}
		return 0.3
	}
	static let leftEdgeInset   : CGFloat = 5
	static let rightEdgeInset  : CGFloat = 5
	static let topEdgeInset    : CGFloat = 5
	static let bottomEdgeInset : CGFloat = 5
	static let downloadImageWithWidth: String = "200"
	static let detailSegueIdentifier = "SearchDetail"
	static let cornerRadiusForCell: CGFloat = 15.0
	static let verticalOffsetofCell: CGFloat = 50
}

struct MovieDetailConstants {
	static let downloadImageWithWidth: String = "500"
	static let imageHeaderViewHeightToWidthRatio: CGFloat = 0.75
}

struct DeviceProperties {
	static var isLandscape: Bool {
		if UIDevice.current.orientation.isLandscape  {
			return true
		} else {
			return false
		}
	}
}
