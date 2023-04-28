//
//  Endpoints.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import Foundation
// MARK: - Move to URL components later
struct Endpoints {
    static let top250MoviesURL = "https://imdb-api.com/en/API/Top250Movies"
    static let searchMovies = "https://imdb-api.com/en/API/SearchMovie"
    static let trailer = "https://imdb-api.com/en/API/YouTubeTrailer"
    static let resizeImage = "https://imdb-api.com/API/ResizeImage?apiKey="
    static let size = "&size=384x528"
    static let url = "&url="
    static let detail = "https://imdb-api.com/en/API/Title"
    static let query = "FullActor,FullCast,Posters,Images,Trailer,Ratings"
    static let apiKey = "k_l342t1pj" /// <--- Past your own API KEY HERE
}
