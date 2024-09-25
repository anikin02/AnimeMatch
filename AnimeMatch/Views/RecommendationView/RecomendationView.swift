//
//  RecomendationView.swift
//  AnimeMatch
//
//  Created by anikin02 on 25.09.2024.
//

import SwiftUI

struct RecomendationView: View {
  @ObservedObject var recomendationViewModel: RecomendationViewModel
  
  init(animeIds: [Int]) {
    recomendationViewModel = RecomendationViewModel(animeIds: animeIds)
  }
  
  var body: some View {
    VStack {
      ScrollView {
        ForEach(recomendationViewModel.recomendationAnime) { anime in
          RecomendationItemView(anime: anime)
        }
        Spacer()
          .frame(height: 400)
      }
      .scrollIndicators(.hidden)
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .onAppear() {
      recomendationViewModel.setRecomendationAnime()
    }
  }
}

struct RecomendationItemView: View {
  let anime: AnimeCatalogItem
  
  var body: some View {
    HStack(alignment: .top) {
      VStack {
        AsyncImage(
          url: URL(string: "https://shikimori.one\(anime.image.original)"),
          content: { image in
            image.resizable()
              .aspectRatio(contentMode: .fit)
              .frame(height: 200)
          },
          placeholder: {
            VStack {
              ProgressView()
                .frame(height: 200)
            }
          })
      }
      
      VStack(alignment: .leading) {
        Text(anime.name)
          .font(.system(size: 20, weight: .black))
        
        HStack {
          Image(systemName: "star.circle.fill")
            .foregroundStyle(.green)
          Text(anime.score)
            .foregroundStyle(.green)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
