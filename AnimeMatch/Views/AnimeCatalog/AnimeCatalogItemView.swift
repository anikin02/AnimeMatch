//
//  AnimeCatalogItemView.swift
//  AnimeMatch
//
//  Created by anikin02 on 25.09.2024.
//

import SwiftUI

struct AnimeCatalogItemView: View {
  var animeItem: AnimeCatalogItem
  
  @EnvironmentObject var animeCatalogViewModel: AnimeCatalogViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      AsyncImage(
        url: URL(string: "https://shikimori.one\(animeItem.image.original)"),
        content: { image in
          image.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(height: 225)
        },
        placeholder: {
          VStack {
            ProgressView()
              .frame(height: 225)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
      )
      Text(animeItem.name)
        .font(.system(size: 17, weight: .heavy))
        .lineLimit(nil)
        .multilineTextAlignment(.leading)
        .frame(alignment: .leading)
      HStack(spacing: 2) {
        Image(systemName: "star.circle.fill")
          .foregroundStyle(.green)
        Text(animeItem.score)
          .foregroundStyle(.green)
        Spacer()
        Button {
          if animeCatalogViewModel.selectedAnimeID.contains(animeItem.id) {
            animeCatalogViewModel.removeSelectedID(id: animeItem.id)
          } else {
            animeCatalogViewModel.addSelectedID(id: animeItem.id)
          }
        } label: {
          Text(animeCatalogViewModel.selectedAnimeID.contains(animeItem.id) ? "Cancel" : "Select")
            .font(.system(size: 17, weight: .black))
            .tint(.white)
            .padding(.horizontal, 10)
            .background(animeCatalogViewModel.selectedAnimeID.contains(animeItem.id) ? .gray : .appPink)
            .clipShape(.capsule)
        }
      }
    }
    .frame(width: 160)
  }
}
