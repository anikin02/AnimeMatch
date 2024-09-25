//
//  AnimeCatalogViewModel.swift
//  AnimeMatch
//
//  Created by anikin02 on 22.09.2024.
//

import Foundation

class AnimeCatalogViewModel: ObservableObject {
  
  var animeCatalog = [AnimeCatalogItem]()
  
  @Published var selectedAnimeID = Set<Int>()
  
  @Published var animeResult = [AnimeCatalogItem]()
  @Published var searchText = String()
  
  init() {
    setSearchAnime()
  }
  
  func setSearchAnime() {
    APIManager.shared.getAnimeCatalog(searchText: searchText) { responce in
      DispatchQueue.main.async {
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
}
