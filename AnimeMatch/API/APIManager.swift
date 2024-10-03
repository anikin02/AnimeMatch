//
//  APIManager.swift
//  AnimeMatch
//
//  Created by anikin02 on 22.09.2024.
//

import Foundation

class APIManager {
  static let shared = APIManager()
  
  var catalogPage: Int = 1
  
  func getAnimeCatalog(searchText: String, completion: @escaping (AnimeCatalog) -> Void) {
    
    guard let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
      return
    }
    
    let urlString: String = "https://shikimori.one/api/animes?limit=50&page=\(catalogPage)&order=ranked&search=\(encodedSearchText)"
    guard let url = URL(string: urlString) else { return }
    
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
      if error != nil {
        print(error!.localizedDescription)
      } else if let data = data {
        do {
          let decoder = JSONDecoder()
          let response = try decoder.decode([AnimeCatalogItem].self, from: data)
          completion(AnimeCatalog(data: response))
        } catch {
          print(error.localizedDescription)
        }
      }
    })
    task.resume()
  }
  
  func getGenres(completion: @escaping ([Genre]) -> Void) {
    let urlString: String = "https://shikimori.one/api/genres"
    
    guard let url = URL(string: urlString) else { return }
    
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
      if error != nil {
        print(error!.localizedDescription)
      } else if let data = data {
        do {
          let decoder = JSONDecoder()
          let response = try decoder.decode([Genre].self, from: data)
          completion(response)
        } catch {
          print(error.localizedDescription)
        }
      }
    })
    task.resume()
  }
  
  func getAnimeDetails(id: Int, completion: @escaping (AnimeDetails) -> Void) {
    let urlString: String = "https://shikimori.one/api/animes/\(id)"
    
    guard let url = URL(string: urlString) else { return }
    
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
      if error != nil {
        print(error!.localizedDescription)
      } else if let data = data {
        do {
          let decoder = JSONDecoder()
          let response = try decoder.decode(AnimeDetails.self, from: data)
          completion(response)
        } catch {
          print(error.localizedDescription)
        }
      }
    })
    task.resume()
  }
  
  func getAnimeSimilar(id: Int, completion: @escaping (AnimeCatalog) -> Void) {
    let urlString: String = "https://shikimori.one/api/animes/\(id)/similar"
    guard let url = URL(string: urlString) else { return }
    
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
      if error != nil {
        print(error!.localizedDescription)
      } else if let data = data {
        do {
          let decoder = JSONDecoder()
          let response = try decoder.decode([AnimeCatalogItem].self, from: data)
          completion(AnimeCatalog(data: response))
        } catch {
          print(error.localizedDescription)
        }
      }
    })
    task.resume()
  }
}
