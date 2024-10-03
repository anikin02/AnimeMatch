//
//  AnimeCatalogViewModel.swift
//  AnimeMatch
//
//  Created by anikin02 on 22.09.2024.
//

import Foundation

class AnimeCatalogViewModel: ObservableObject {
  @Published var animeResult = [AnimeCatalogItem]()
  @Published var genres = [Genre]()
  
  @Published var searchText = String()
  @Published var selectedAnimeID = Set<Int>()
  
  @Published var selectedGenre = String()
  
  init() {
    setSearchAnime()
    setGenres()
  }
  
  func setGenres() {
    APIManager.shared.getGenres() { responce in
      DispatchQueue.main.async {
        self.genres = responce
      }
    }
  }
  
  func setSearchAnime() {
    APIManager.shared.getAnimeCatalog(searchText: searchText) { responce in
      DispatchQueue.main.async {
        self.animeResult = []
        self.animeResult = responce.data
      }
    }
  }
  
  func addSelectedID(id: Int) {
    selectedAnimeID.insert(id)
  }
  
  func removeSelectedID(id: Int) {
    selectedAnimeID.remove(id)
  }
  
  func clearSelectedIDs() {
    selectedAnimeID = []
  }
}
