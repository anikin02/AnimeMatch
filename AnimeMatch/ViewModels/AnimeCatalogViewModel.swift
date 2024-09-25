//
//  AnimeCatalogViewModel.swift
//  AnimeMatch
//
//  Created by anikin02 on 22.09.2024.
//

import Foundation

class AnimeCatalogViewModel: ObservableObject {
  
  var animeCatalog = [AnimeCatalogItem]()
  
  var selectedAnimeID = Set<Int>()
  var similarAnime = [AnimeCatalogItem]()
  
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
  
  func setAnimeSimilar(completion: @escaping () -> Void) {
    let dispatchGroup = DispatchGroup()
    
    for item in similarAnime {
      dispatchGroup.enter()
      
      APIManager.shared.getAnimeSimilar(id: item.id) { response in
        DispatchQueue.main.async {
          self.similarAnime.append(contentsOf: response.data)
          dispatchGroup.leave()
        }
      }
    }
    dispatchGroup.notify(queue: .main) {
      completion()
    }
  }
  
  func setRecomendationAnime() -> [Int] {
    // id: value
    var valuesRecomendationAnime = [Int:Double]()
    
    for anime in similarAnime {
      if let value = valuesRecomendationAnime[anime.id] {
        valuesRecomendationAnime[anime.id] = value + (Double(anime.score) ?? 1)
      } else {
        valuesRecomendationAnime[anime.id] = (Double(anime.score) ?? 1)
      }
    }
    
    return valuesRecomendationAnime
      .sorted(by: { $0.value > $1.value })
      .prefix(10)
      .map { $0.key }
  }
  
  func fetchAnimeData() {
    setAnimeSimilar {
      self.setRecomendationAnime()
    }
  }
}
