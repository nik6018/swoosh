//
//  MovieSearchViewController.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 13/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController, UISearchBarDelegate {

	@IBOutlet private weak var collectionView: UICollectionView!
	@IBOutlet private weak var searchBar: UISearchBar!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet private weak var infoLabel: UILabel!
	
	private var searchedMovies = [Movie]()
	private var searchTerm = ""
	
	private var currentPageNumber = 1
	private var pageLimit: Int?
	
	
	private var queryService = NetworkingHub()
	private var imageCache = NSCache<AnyObject, AnyObject>()
	
	private var infoText: String {
		get {
			return infoLabel.text ?? ""
		}
		set(newValue){
			if infoLabel.isHidden {
				infoLabel.isHidden = false
			}
			infoLabel.text = newValue
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		searchBar.delegate = self
		collectionView.prefetchDataSource = self
		collectionView.collectionViewLayout = ColumnLayout()
		activityIndicator.stopAnimating()
		infoText = "Search for Movies"
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(collectionViewTapped(_:)))
		//allows Collectionview cell to reconize the Tap
		tapGesture.cancelsTouchesInView = false
		view.addGestureRecognizer(tapGesture)
    }
	
	// MARK: - Networking
	
	private func updateDataSource() {
		 // make the network call
		
		activityIndicator.startAnimating()
		
		queryService.searchForMovie(
						withParams: ["page": String(currentPageNumber), "query": searchTerm])
						{ (movies, error, totalNumberOfPages) in
							
			// check for any errors
			if !error.isEmpty {
				// Display some alert
				print("Cannot get Movie from The Server")
			} else {
				//get the data from the request
				self.searchedMovies += movies
				self.pageLimit = totalNumberOfPages
				self.imageCache.removeAllObjects()
				
				//reload the collectionView on the main Q
				DispatchQueue.main.async {
					if self.searchedMovies.count == 0 {
						self.infoText = "No Movies Found"
					}
					self.collectionView.reloadData()
					self.activityIndicator.stopAnimating()
				}
			}
		}
	}
	
	// MARK: - SearchBar Delegate
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		//clear the Existing DataSource
		infoLabel.isHidden = true
		searchedMovies.removeAll()
		collectionView.reloadData()
		
		//now search
		if let text = searchBar.text, !text.isEmpty {
			print("With Text \(text)")
			searchBar.resignFirstResponder()
			searchTerm = text
			updateDataSource()
		}
	}
	

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		dismissKeyBoard()
		
		if segue.identifier == MovieSearchConstants.detailSegueIdentifier {
			if let indexPath = collectionView.indexPathsForSelectedItems?.first {
				let movieDetailViewController = segue.destination as! MovieDetailViewController
				let movie = searchedMovies[indexPath.row]
				movieDetailViewController.movie = movie
			} else {
				fatalError("Unable to Find the Index Path")
			}
		}
	}
	
	// MARK:- Private methods
	private func dismissKeyBoard() {
		searchBar.resignFirstResponder()
	}
	
	@objc private func collectionViewTapped(_ sender: Any) {
		dismissKeyBoard()
	}
}

extension MovieSearchViewController:
	UICollectionViewDelegate,
	UICollectionViewDataSource,
	UICollectionViewDataSourcePrefetching
	//UICollectionViewDelegateFlowLayout,
{
	
	// MARK: - CollectionView Delegate
	
	func collectionView(
		_ collectionView: UICollectionView,
		willDisplay cell: UICollectionViewCell,
		forItemAt indexPath: IndexPath) {
		
		let movie = searchedMovies[indexPath.row]
		let path = NSString(string: movie.posterURL)
		
		if let cachedImage = imageCache.object(forKey: path) as? UIImage{
			let movieCell = cell as! MovieSearchCollectionViewCell
			movieCell.updateCell(
				withImage: cachedImage,
				withTitle: movie.title,
				withRating: movie.rating)
		} else {
			
			// do the heavy lifting of making the Network Call
			queryService.fetchMoviePoster(withRelativePath: path as String, withImageWidth: MovieBrowserConstants.downloadImageWithWidth) { (data, error) in
				
				guard let movieIndex = self.searchedMovies.index(of: movie) else {
					return
				}
				
				let movieIndexPath = IndexPath(row: movieIndex, section: 0)


				if let movieCell = self.collectionView.cellForItem(at: movieIndexPath) as? MovieSearchCollectionViewCell {
					if let imageData = data, let moviePoster = UIImage(data: imageData) {
						self.imageCache.setObject(moviePoster, forKey: path)
						
						movieCell.updateCell(
							withImage: moviePoster,
							withTitle: movie.title,
							withRating: movie.rating)
						
					} else {
						print("Cannot Download Image due to : \(error)")
						movieCell.updateCell(
							withImage: nil,
							withTitle: nil,
							withRating: nil)
					}
				}
			}
		}
		
		// for pagination
		if indexPath.row == (searchedMovies.count - 1) {
			currentPageNumber += 1
			if currentPageNumber < pageLimit! {
				updateDataSource()
			}
		}
	}
	
	// MARK:- Data Source
	
	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int) -> Int {
		
		return searchedMovies.count
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		if let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: MovieSearchCollectionViewCell.reuseIdentifier,
			for: indexPath) as? MovieSearchCollectionViewCell {
			
			
			cell.layer.cornerRadius = MovieSearchConstants.cornerRadiusForCell
			return cell
		}
		
		return UICollectionViewCell()
	}
	
	
	// MARK:- Flow Layout Delegate
	
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//		return UIEdgeInsets(
//			top: MovieSearchConstants.topEdgeInset,
//			left: MovieSearchConstants.leftEdgeInset,
//			bottom: MovieSearchConstants.bottomEdgeInset,
//			right: MovieSearchConstants.rightEdgeInset)
//	}
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//		let offset = (MovieSearchConstants.leftEdgeInset + MovieSearchConstants.rightEdgeInset)
//
//		let width = (collectionView.frame.width) - (offset)
//		let height = width * CGFloat(MovieSearchConstants.widthToHeightRatioForSearchCell)
//		return CGSize(width: width, height: height + MovieSearchConstants.verticalOffsetofCell)
//	}
	
	// MARK:- Data Prefetching
	
	// TODO:- Implement the Prefetching using NSOperation
	
	func collectionView(
		_ collectionView: UICollectionView,
		prefetchItemsAt indexPaths: [IndexPath]) {
	
		indexPaths.forEach { (indexPath) in
			let movie = searchedMovies[indexPath.row]
			let path = NSString(string: movie.posterURL)
			
			if imageCache.object(forKey: path) == nil {
				// do the network call
				queryService.fetchMoviePoster(
					withRelativePath: path as String,
					withImageWidth: MovieBrowserConstants.downloadImageWithWidth,
					completion: { (data, errorString) in
						if let imageData = data, let image = UIImage(data: imageData) {
							self.imageCache.setObject(image, forKey: path)
						}
				})
			}
			
		}
	}
}
