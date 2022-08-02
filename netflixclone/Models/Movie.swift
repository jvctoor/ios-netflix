//
//  Movie.swift
//  netflixclone
//
//  Created by João Victor on 01/08/22.
//

import Foundation

struct TrendingMoviesReponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double 
}
