//
//  AnimeCatalogView.swift
//  AnimeMatch
//
//  Created by anikin02 on 22.09.2024.
//

import SwiftUI

struct AnimeCatalogView: View {
  @ObservedObject var animeCatalogViewModel = AnimeCatalogViewModel()
  
  var body: some View {
    NavigationStack {
      ZStack {
        VStack {
          // MARK: Search
          HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search...", text: $animeCatalogViewModel.searchText)
              .onChange(of: animeCatalogViewModel.searchText) {
                animeCatalogViewModel.setSearchAnime()
              }
          }
          .padding(.horizontal, 20)
          .padding(.vertical, 15)
          .background(Color(.systemGray6))
          .clipShape(.rect(cornerRadius: 20))
          .padding(.horizontal, 20)
          .padding(.bottom, 15)
          
          // MARK: Items
          ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), alignment: .top), GridItem(.flexible(), alignment: .top)]) {
              ForEach(animeCatalogViewModel.animeResult) { animeItem in
                NavigationLink(destination: AnimeDetailsView(id: animeItem.id)) {
                  AnimeCatalogItemView(animeItem: animeItem)
                    .environmentObject(animeCatalogViewModel)
                }
                .tint(.black)
              }
            }
            .padding(.horizontal, 15)
          }
          .scrollIndicators(.hidden)
        }
        
        // MARK: RecomendButton
        HStack {
          NavigationLink(destination:
                          RecomendationView(animeIds: Array(animeCatalogViewModel.selectedAnimeID))) {
            Text("Recomend")
              .font(.system(size: 30, weight: .black))
              .tint(.white)
              .padding(.vertical, 15)
              .padding(.horizontal, 40)
              .background(.appPink)
              .clipShape(.capsule)
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
      }
    }
  }
}

#Preview {
  AnimeCatalogView()
}
