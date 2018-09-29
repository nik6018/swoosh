//
//  MovieSearchDataSource.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 13/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class MovieSearchDataSource: NSObject, UICollectionViewDataSource {
	
	var searchedMovieList = [Movie]()
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		//return searchedMovieList.count
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: MovieSearchCollectionViewCell.reuseIdentifier,
				for: indexPath) as? MovieSearchCollectionViewCell {
			
			// do the heavy lifting of making the Network Call
			cell.updateCell(withImage: nil, withTitle: nil, withRating: nil)
			
			return cell
		}
		
		return UICollectionViewCell()
	}
	
	func searchForMovie(forTerm term: String) {
		
		// call the n/w func here and fetch the data
		// update the array
		// reload the collectionView passed in the completion handler
	}
	
}
