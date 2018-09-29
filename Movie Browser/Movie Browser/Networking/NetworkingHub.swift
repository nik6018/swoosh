//
//  NetworkingHub.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 13/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation

enum ParseResult {
	case success([Movie])
	case failure(Error)
}

struct APIResponse: Decodable {
	var page: Int
	var totalPages: Int
	var movies: [Movie]
	
	enum CodingKeys: String, CodingKey {
		case page, totalPages = "total_pages"
		case movies = "results"
	}
}


class NetworkingHub {

	private let networkSession: URLSession = {
		let config = URLSessionConfiguration.default
		return URLSession(configuration: config)
	}()
	
	private var networkDataTask: URLSessionDataTask?
	
	private let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()
	
	private let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		return decoder
	}()
	
	// function to fetch all the movies
	func fetchMovieList(
		withEndPoint endPoint: Endpoints,
		withParams params: [String: String],
		completion: @escaping ([Movie], String) -> Void) {
	
		// Get the URL for the Requested EndPoint
		if let requestURL = TMDb.getEndPointURL(fromEndPoint: endPoint, withParams: params) {
			
			// make the request
			print(requestURL)
			networkDataTask = networkSession.dataTask(with: requestURL) { (data, response, error) in
				
				defer {
					self.networkDataTask = nil
				}
				
				if let networkError = error {
					completion([], networkError.localizedDescription)
				}
				
				if let responseData = data {
					do {
						
						//debug code
//						let j = try JSONSerialization.jsonObject(with: responseData, options: [])
//						as! [AnyHashable: Any]
//						print(j)
						
						self.decoder.dateDecodingStrategy = .formatted(self.dateFormatter)
						let jsonData = try self.decoder.decode(APIResponse.self, from: responseData)
						
						completion(jsonData.movies, "")
					} catch {
						print(error)
						completion([], error.localizedDescription)
					}
				}
			}
			
			networkDataTask?.resume()
			
		} else {
			completion([], "Cannot Create the API URL for Request")
		}
	}
	
	//function to fetch the movie poster or image
	
	func fetchMoviePoster(
		withRelativePath path: String,
		withImageWidth width: String,
		completion: @escaping ((Data?, String) -> Void)) {
		
		//get the URL to fetch Image
		if let requestURL = TMDb.getAbsoluteImageURL(withPath: path, withImageWidth: width) {
			
			networkDataTask = networkSession.dataTask(with: requestURL){ (data, resposne, error) in
				
				defer {
					self.networkDataTask = nil
				}
				
				if let networkError = error {
					DispatchQueue.main.async {
						completion(nil, networkError.localizedDescription)
					}
				}
				
				if let imageData = data {
					DispatchQueue.main.async {
						completion(imageData, "")
					}
				}
			}
			
			networkDataTask?.resume()
		} else {
			completion(nil, "Cannot build URL for PosterDownload")
		}
	}
	
	func searchForMovie(
		withParams params: [String: String],
		completion: @escaping ([Movie], String, Int) -> Void) {
		
		if let requestURL = TMDb.getEndPointURL(
									fromEndPoint: .search, withParams: params){
			
			networkDataTask = networkSession.dataTask(with: requestURL) { (data, response, error) in
				
				defer {
					self.networkDataTask = nil
				}
				
				if let networkError = error {
					completion([], networkError.localizedDescription, 0)
				}
				
				if let responseData = data {
					do {
						
						//debug code
//						let j = try JSONSerialization.jsonObject(with: responseData, options: [])						as! [AnyHashable: Any]
//						print(j)
						
						self.decoder.dateDecodingStrategy = .formatted(self.dateFormatter)
						let jsonData = try self.decoder.decode(APIResponse.self, from: responseData)
						print(jsonData.totalPages)
						
						completion(jsonData.movies, "", jsonData.totalPages)
					} catch {
						print(error)
						completion([], error.localizedDescription, 0)
					}
				}
			}
			
			networkDataTask?.resume()
		} else {
			completion([], "Cannot create the API URL", 0)
		}
	}
}





