//
//  TMDbAPI.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 13/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation

enum Endpoints {
	case popular
	case topRated
	case search
	
	var endPointPath : String {
		switch self {
		case .popular:
			return "movie/popular"
		case .topRated:
			return "movie/top_rated"
		case .search:
			return "search/movie"
		}
	}
}

struct TMDb {
	
	typealias ExtraParam = [String: String]?
	
	private static let baseAPIString = "https://api.themoviedb.org/3/"
	private static let API_KEY = "7d79f24c134d81e3e0a52a621809ae6f"
	private static let imageEndPointString = "https://image.tmdb.org/t/p/w"
	
	static func getEndPointURL(fromEndPoint endPoint: Endpoints, withParams params: ExtraParam) -> URL? {
		
		var components = URLComponents(string: baseAPIString+endPoint.endPointPath)!
		var queryItems = [URLQueryItem]()
		
		let baseParams = [
			"api_key" : API_KEY
		]
		
		for (key, value) in baseParams {
			let queryItem = URLQueryItem(name: key, value: value)
			queryItems.append(queryItem)
		}
		
		if let extraParams = params {
			for (key, value) in extraParams {
				let queryItem = URLQueryItem(name: key, value: value)
				queryItems.append(queryItem)
			}
		}
		
		components.queryItems = queryItems
		
		if let requestURL = components.url {
			return requestURL
		} else {
			fatalError("Cannot Create EndPoint URL, something is wrong")
		}
	}
	
	static func getAbsoluteImageURL(
					withPath path: String,
					withImageWidth width: String) -> URL? {
		
		let urlString = TMDb.imageEndPointString+width+path
		return URL(string: urlString)
	}
}






