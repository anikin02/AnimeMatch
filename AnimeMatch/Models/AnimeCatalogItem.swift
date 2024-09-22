//
//  AnimeCatalogItem.swift
//  AnimeMatch
//
//  Created by anikin02 on 22.09.2024.
//

import Foundation

struct AnimeCatalog: Codable {
  var data: [AnimeCatalogItem]
}

struct AnimeCatalogItem: Identifiable, Hashable, Codable, Equatable {
  var id: Int
  var name: String
  var russian: String
  var image: ImageAnime
  var score: String
  
  static func == (lhs: AnimeCatalogItem, rhs: AnimeCatalogItem) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
      hasher.combine(id)
  }
}

struct ImageAnime: Codable {
  var original: String
}
