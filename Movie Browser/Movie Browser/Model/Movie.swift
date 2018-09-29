//
//  Movie.swift
//  Movie Browser
//
//  Created by Nikhil Muskur on 13/08/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation

struct Movie: Hashable, Decodable {

	var hashValue: Int {
		return movieID
	}
	
	static func ==(lhs: Movie, rhs: Movie) -> Bool {
		return lhs.movieID == rhs.movieID
	}
	
	var movieID: Int
	var title: String
	var posterURL: String
	var overview: String
	var rating: Double
	var releaseDate: Date
	var votesForRating: Int
	var movieLargePosterURL: String
	
	enum CodingKeys: String, CodingKey {
		case movieID = "id"
		case rating = "vote_average"
		case posterURL = "poster_path"
		case overview, title 
		case votesForRating = "vote_count"
		case movieLargePosterURL = "backdrop_path"
		case releaseDate = "release_date"
		
	}
	
	init(from decoder: Decoder) throws {
		let movie = try decoder.container(keyedBy: CodingKeys.self)
		movieID = try movie.decode(Int.self, forKey: .movieID)
		title = try movie.decode(String.self, forKey: .title)
		//-----------
		do {
			posterURL = try movie.decode(String.self, forKey: .posterURL)
		} catch { posterURL = "" }
		
		do {
			movieLargePosterURL = try movie.decode(String.self, forKey: .movieLargePosterURL)
		} catch  { movieLargePosterURL = "" }
		
		do {
			releaseDate = try movie.decode(Date.self, forKey: .releaseDate)
		} catch  { releaseDate = Date(timeIntervalSince1970: 0) }
		//-----------
		overview = try movie.decode(String.self, forKey: .overview)
		rating = try movie.decode(Double.self, forKey: .rating)
		
		votesForRating = try movie.decode(Int.self, forKey: .votesForRating)
	}
	
	
}

/*
init(
movieID: Int,
title: String,
posterURL: String,
overview: String,
rating: Double,
releaseDate: Date,
votesForRating: Int,
movieLargePosterURL: String) {

self.movieID = movieID
self.title = title
self.posterURL = posterURL
self.overview = overview
self.rating = rating
self.releaseDate = releaseDate
self.votesForRating = votesForRating
self.movieLargePosterURL = movieLargePosterURL
}

init(from decoder: Decoder) throws {
let movie = try decoder.container(keyedBy: CodingKeys.self)
let movieID = try movie.decode(Int.self, forKey: .movieID)
let title = try movie.decode(String.self, forKey: .title)
let posterURL = try movie.decode(String.self, forKey: .posterLink)
let overview = try movie.decode(String.self, forKey: .overview)
let rating = try movie.decode(Double.self, forKey: .rating)
let releaseDate = try movie.decode(Date.self, forKey: .releaseDate)
let votesForRating = try movie.decode(Int.self, forKey: .votesForRating)
let movieLargePosterURL = try movie.decode(String.self, forKey: .movieLargePosterURL)

print(movieID,title,posterURL,overview, separator: "====", terminator: "\n")

self.init(
movieID: movieID,
title: title,
posterURL: posterURL,
overview: overview,
rating: rating,
releaseDate: releaseDate,
votesForRating: votesForRating,
movieLargePosterURL: movieLargePosterURL)
}



*/
