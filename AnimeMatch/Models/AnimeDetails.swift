//
//  AnimeDetails.swift
//  AnimeMatch
//
//  Created by anikin02 on 23.09.2024.
//

import Foundation

struct AnimeDetails: Codable {
  var name: String
  var english: [String]
  var score: String
  var image: ImageAnime
}
