//
//  RecomendationViewModel.swift
//  AnimeMatch
//
//  Created by anikin02 on 25.09.2024.
//

import Foundation

class RecomendationViewModel: ObservableObject {
  
  @Published var recomendationAnime = [AnimeCatalogItem]()
  var animeIds = [Int]()
  var similarAnime = [AnimeCatalogItem]()
  
  init(animeIds: [Int]) {
    self.animeIds = animeIds
  }
  
  func setAnimeSimilar(completion: @escaping () -> Void) {
    let dispatchGroup = DispatchGroup()
    for id in animeIds {
      dispatchGroup.enter()
      
      APIManager.shared.getAnimeSimilar(id: id) { response in
        DispatchQueue.main.async {
          self.similarAnime.append(contentsOf: response.data.prefix(10))
          dispatchGroup.leave()
        }
      }
    }
    dispatchGroup.notify(queue: .main) {
      completion()
    }
  }
  
  func setRecomendationAnime() {
    setAnimeSimilar {
      var valuesRecomendationAnime = [AnimeCatalogItem:Double]()
      
      for anime in self.similarAnime {
        if let value = valuesRecomendationAnime[anime] {
          valuesRecomendationAnime[anime] = value + 10
        } else {
          valuesRecomendationAnime[anime] = (Double(anime.score) ?? 1)
        }
      }
      self.recomendationAnime = valuesRecomendationAnime
        .sorted(by: { $0.value > $1.value })
        .prefix(10)
        .map { $0.key }
    }
  }
  
}
