//
//  AnimeDetailsViewModel.swift
//  AnimeMatch
//
//  Created by anikin02 on 23.09.2024.
//

import Foundation

class AnimeDetailsViewModel: ObservableObject {
  @Published var anime: AnimeDetails?
  
  func setAnime(id: Int)  {
    APIManager.shared.getAnimeDetails(id: id) { responce in
      DispatchQueue.main.async {
        self.anime = responce
      }
    }
  }
}
