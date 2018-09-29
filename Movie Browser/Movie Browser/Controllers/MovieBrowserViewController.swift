//
//  PopularMovieViewController.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 13/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class MovieBrowserViewController: UIViewController {
	
	@IBOutlet private weak var collectionView: UICollectionView!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	private var movieList = [Movie]()
	private let imageCache = NSCache<AnyObject, AnyObject>()
	
	private var queryService = NetworkingHub()
	private var currentPage = 1
	
	var sortPreference = SortType.popular

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		activityIndicator.stopAnimating()
		collectionView.prefetchDataSource = self
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		//do overriding stuff
		if movieList.isEmpty {
			downloadMovieList()
		}
	}
	
	// MARK: - Networking
	
	private func downloadMovieList() {
		
		//start animating the spinner
		activityIndicator.startAnimating()
		
		let endPoint: Endpoints
		
		switch sortPreference{
		case .popular:
			endPoint = .popular
		case .topRated:
			endPoint = .topRated
		}
		
		queryService.fetchMovieList(
						withEndPoint: endPoint,
						withParams: ["page": String(currentPage)]) { (movies, error) in
	
			// check for any errors
			if !error.isEmpty {
				// Display some alert
				print(error)
			} else {
				//get the data from the request
				self.movieList += movies
				
				//reload the collectionView on the main Q
				DispatchQueue.main.async {
					self.collectionView.reloadData()
					self.activityIndicator.stopAnimating()
				}
			}
		}
	}
	
	// MARK: - Action Methods
	
	@IBAction private func sortMovies(_ sender: Any) {
		
		let alertController = UIAlertController(
								title: "Sort Preference",
								message: "Set how you want Sort the movies",
								preferredStyle: .actionSheet)
		
		let sortByTopRatedAction = UIAlertAction(title: "Top Rated", style: .default) { _ in
			self.sortPreference = .topRated
			self.refreshCollectionView()
		}
		
		let sortByPopularityAction = UIAlertAction(title: "Popular", style: .default) { _ in
			self.sortPreference = .popular
			self.refreshCollectionView()
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		
		alertController.addAction(sortByTopRatedAction)
		alertController.addAction(sortByPopularityAction)
		alertController.addAction(cancelAction)
		
		present(alertController, animated: true, completion: nil)
	}

	private func refreshCollectionView() {
		movieList = []
		collectionView.reloadData()
		downloadMovieList()
		// scroll to the Top
		collectionView.setContentOffset(CGPoint.zero, animated: false)
	}
	
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == MovieBrowserConstants.detailSegueIdentifier { 
			if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
				let movieDetailViewController = segue.destination as! MovieDetailViewController
				let movie = movieList[selectedIndexPath.row]
				movieDetailViewController.movie = movie
			} else {
				fatalError("Unable to Find the Index Path")
			}
		}
	}

}

extension MovieBrowserViewController:
	UICollectionViewDelegate,
	UICollectionViewDelegateFlowLayout,
	UICollectionViewDataSource,
	UICollectionViewDataSourcePrefetching
{
	
	// MARK: - CollectionView Delegate
	
	func collectionView(
			_ collectionView: UICollectionView,
			willDisplay cell: UICollectionViewCell,
			forItemAt indexPath: IndexPath) {
		
		if indexPath.row == (movieList.count - 1) {
			currentPage += 1
			downloadMovieList()
		}
	}
	
	// MARK: - CollectionView DataSource
	
	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int) -> Int {
		
		return movieList.count
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let movie = movieList[indexPath.row]
		let path = NSString(string: movie.posterURL)
		
		
		if let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: MovieBrowserCollectionViewCell.reuseIdentifier,
				for: indexPath) as? MovieBrowserCollectionViewCell {
			
			if let cachedImage = imageCache.object(forKey: path) as? UIImage{
				cell.updateCell(withImage: cachedImage)
			} else {
				
				// do the heavy lifting of making the Network Call
				queryService.fetchMoviePoster(withRelativePath: (path as String), withImageWidth: MovieBrowserConstants.downloadImageWithWidth) { (data, error) in
					
					if !error.isEmpty {
						print("Cannot Download Image due to : \(error)")
						DispatchQueue.main.async { cell.updateCell(withImage: nil) }
					}
					
					if let imageData = data, let moviePoster = UIImage(data: imageData) {
						self.imageCache.setObject(moviePoster, forKey: path)
						DispatchQueue.main.async { cell.updateCell(withImage: moviePoster) }
					}
				}
			}

			return cell
		}
		return UICollectionViewCell()
	}
	
	// MARK: - Flow Layout Delegate
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int) -> UIEdgeInsets {
		
//		let itemSize = collectionView.size
		
		return UIEdgeInsets(
					top: MovieBrowserConstants.topEdgeInset,
					left: MovieBrowserConstants.leftEdgeInset,
					bottom: MovieBrowserConstants.bottomEdgeInset,
					right: MovieBrowserConstants.rightEdgeInset)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let width = (collectionView.frame.width / MovieBrowserConstants.numberOfRows) - 1
		print(width)
		let height = width + (width * MovieBrowserConstants.widthToHeightRatioForListCell)
		return CGSize(width: width, height: height)
	}
	
	// MARK:- Data Prefetching
	
	// TODO:- Implement the Prefetching using NSOperation
	func collectionView(
		_ collectionView: UICollectionView,
		prefetchItemsAt indexPaths: [IndexPath]) {
		
		indexPaths.forEach { (indexPath) in
			let movie = movieList[indexPath.row]
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

enum SortType: String {
	case popular = "popular"
	case topRated = "top_rated"
}


