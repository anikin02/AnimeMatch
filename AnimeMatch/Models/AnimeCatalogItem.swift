//
//  AnimeCatalogItem.swift
//  AnimeMatch
//
//  Created by anikin02 on 22.09.2024.
//

import Foundation

struct AnimeCatalogItem: Codable {
  var id: Int
  var name: String
  var russian: String
  var image: ImageAnime
  var score: Double
}

struct ImageAnime: Codable {
  var original: String
}
