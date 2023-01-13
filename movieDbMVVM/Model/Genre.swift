//
//  Genre.swift
//  movieDbMVVM
//
//  Created by Hansel Matthew on 21/10/22.
//

import Foundation

struct GenresResponse: Codable {
    let genres: [GenreResult]
}

struct GenreResult: Codable {
    let id: Int
    let name: String
}
