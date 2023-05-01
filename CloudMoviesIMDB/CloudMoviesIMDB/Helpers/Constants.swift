//
//  Constants.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 30.04.2023.
//

import Foundation

struct Constants {
    static let apiKey = "k_l7vmnrru" /// <--- Past your own API KEY HERE
    /// size for image  dowloading will paste into url
    static let size = "256x352"
    /// QueryItem but cant use with url components  - api rules
    static let fullDetail = "FullActor,FullCast,Posters,Images,Trailer,Ratings"
}
