//
//  ColumnLayout.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 21/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ColumnLayout: UICollectionViewFlowLayout {

	
	override func prepare() {
		super.prepare()
		
		//overide behaviour
		guard let cv = collectionView else { return }
		
		let offset = (MovieSearchConstants.leftEdgeInset + MovieSearchConstants.rightEdgeInset)
		
		let availableWidth = cv.bounds.insetBy(dx: cv.layoutMargins.left, dy: cv.layoutMargins.top).size.width
		
		let maxWidth: CGFloat = 300
		let maxNumberOfColumns = Int(availableWidth / maxWidth)
		let cellWidth =  (availableWidth / CGFloat(maxNumberOfColumns)).rounded(.down)
		
//		let width = (cv.frame.width) - (offset)
		let width = cellWidth - (offset)
		let height = width * CGFloat(MovieSearchConstants.widthToHeightRatioForSearchCell)
		itemSize = CGSize(width: width, height: height + MovieSearchConstants.verticalOffsetofCell)
		
		sectionInset = UIEdgeInsets(
			top: MovieSearchConstants.topEdgeInset,
			left: MovieSearchConstants.leftEdgeInset,
			bottom: MovieSearchConstants.bottomEdgeInset,
			right: MovieSearchConstants.rightEdgeInset)
		
		sectionInsetReference = .fromContentInset
		
	}
}
