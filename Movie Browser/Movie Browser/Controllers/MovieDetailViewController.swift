//
//  MovieDetailViewController.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 15/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class MovieDetailViewController: UITableViewController {
	
	// will be set by the seguing VC
	var movie: Movie!
	
	private var dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()
	private let queryService = NetworkingHub()
	private var imageHeaderViewHeight: CGFloat {
		get {
			return tableView.bounds.width * MovieDetailConstants.imageHeaderViewHeightToWidthRatio
		}
	}
	
	//private var headerImageView: ImageHeaderView!
	var imageHeaderView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.largeTitleDisplayMode = .never
		// check if we have the movie object
		if movie == nil {
			fatalError("Cannot Find the movie object to show info")
		}
		
		setUpImageHeader()
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 140
		//hide any extra empty cells
		tableView.tableFooterView = nil
		fetchBackDropPoster()
    }

    // MARK: - UITableView DataSource
	
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		switch indexPath.row {
		case 0:
			let cell = super.tableView(tableView, cellForRowAt: indexPath) as! DetailTitleTableViewCell
			cell.updateTitle(movie.title)
			return cell
			
		case 1:
			let cell = super.tableView(tableView, cellForRowAt: indexPath) as! DetailOverviewTableViewCell
			cell.updateOverView(movie.overview)
			return cell
			
		case 2:
			let cell = super.tableView(tableView, cellForRowAt: indexPath) as! DetailRatingTableViewCell
			cell.updateRating(String(movie.rating), String(movie.votesForRating))
			return cell
			
		case 3:
			let dateWithoutTime = dateFormatter.string(from: movie.releaseDate)
			let cell = super.tableView(tableView, cellForRowAt: indexPath)
			cell.textLabel?.text = "Release Date: \(dateWithoutTime)"
			return cell
			
		default:
			return UITableViewCell()
		}
    }
	
	// MARK: - Private Methods
	
	func setUpImageHeader() {
		imageHeaderView = tableView.tableHeaderView as! UIImageView
		tableView.tableHeaderView = nil
		
		tableView.addSubview(imageHeaderView)
		tableView.contentInset = UIEdgeInsets(top: imageHeaderViewHeight, left: 0, bottom: 0, right: 0)
		imageHeaderView.frame = CGRect(x: 0, y: -imageHeaderViewHeight, width: tableView.bounds.width, height: imageHeaderViewHeight)
	}
	
	func fetchBackDropPoster() {
		
		// Some Movies don't have a large poster so instead use the small movie poster
		
		let path = NSString(string: movie.movieLargePosterURL)
		
		queryService.fetchMoviePoster(withRelativePath: (path as String), withImageWidth: MovieDetailConstants.downloadImageWithWidth) { (data, error) in
			
			if !error.isEmpty {
				print("Cannot Download Image due to : \(error)")
				DispatchQueue.main.async {
					self.imageHeaderView.image = nil
				}
			}
			
			if let imageData = data, let moviePoster = UIImage(data: imageData) {
				DispatchQueue.main.async {
					self.imageHeaderView.image = moviePoster
				}
			}
		}
	}
	
	// MARK: - UITableView Delegate
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
}
