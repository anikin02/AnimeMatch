//
//  AnimeCatalogViewModel.swift
//  AnimeMatch
//
//  Created by anikin02 on 22.09.2024.
//

import Foundation

class AnimeCatalogViewModel: ObservableObject {
  
  @Published var animeCatalog = [AnimeCatalogItem]()
  
  init() {
    APIManager.shared.getAnimeCatalog { responce in
      DispatchQueue.main.async {
        self.animeCatalog = responce.data
      }
    }
  }
}
