//
//  AnimeDetailsView.swift
//  AnimeMatch
//
//  Created by anikin02 on 22.09.2024.
//

import SwiftUI

struct AnimeDetailsView: View {
  var id: Int
  
  @ObservedObject var animeDetailsViewModel = AnimeDetailsViewModel()
  
  init(id: Int) {
    self.id = id
  }
  
  var body: some View {
    VStack {
      ScrollView {
        VStack {
          
          if let imageUrlString = animeDetailsViewModel.anime?.image.original,
             let imageUrl = URL(string: "https://shikimori.one\(imageUrlString)") {
            AsyncImage(
              url: imageUrl,
              content: { image in
                image.resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 350, height: 500)
              },
              placeholder: {
                VStack {
                  ProgressView()
                    .frame(width: 225, height: 331)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
              }
            )
          } else {
            VStack {
              ProgressView()
                .frame(width: 225, height: 331)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
          Text(animeDetailsViewModel.anime?.name ?? "Loading...")
            .font(.system(size: 30, weight: .black))
          Text(animeDetailsViewModel.anime?.english.first ?? "Loading...")
            .font(.system(size: 20, weight: .bold))
          HStack {
            ForEach(0..<5, id: \.self) { counterStar in
              Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(Int((Double(animeDetailsViewModel.anime?.score ?? "") ?? 0)/2) > Int(counterStar) ? .appPink : .gray)
                .frame(width: 24, height: 24)
            }
            Text(animeDetailsViewModel.anime?.score ?? "Loading...")
              .font(.system(size: 22))
          }
        }
        
        //        VStack(alignment: .leading) {
        //          Text("Kind: TV")
        //            .font(.system(size: 18))
        //          let genresText = genres.joined(separator: ", ")
        //          Text("Genres: \(genresText)")
        //            .font(.system(size: 18))
        //        }
        
        VStack(alignment: .leading) {
          Text("Secreanshots")
            .font(.system(size: 20))
        }
      }
      .scrollIndicators(.hidden)
      .padding(.top)
    }
    .padding(.horizontal, 20)
    .onAppear() {
      animeDetailsViewModel.setAnime(id: id)
    }
  }
}
