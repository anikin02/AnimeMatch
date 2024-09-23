//
//  AnimeDetailsViewModel.swift
//  AnimeMatch
//
//  Created by anikin02 on 23.09.2024.
//

import Foundation

class AnimeDetailsViewModel: ObservableObject {
  let id: Int
  
  var anime: AnimeDetails?
  
  init(id: Int) {
    self.id = id
    
    APIManager.shared.getAnimeDetails(id: id) { responce in
      DispatchQueue.main.async {
        self.anime = responce
      }
    }
  }
  
}
