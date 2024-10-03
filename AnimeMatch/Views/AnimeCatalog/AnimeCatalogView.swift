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
            Spacer()
              .frame(height: 400)
          }
          .scrollIndicators(.hidden)
        }
        
        // MARK: RecomendButton and ClearButtton
        HStack {
          NavigationLink(destination:
                          RecomendationView(animeIds: Array(animeCatalogViewModel.selectedAnimeID))) {
            Text("Recomend")
              .font(.system(size: 30, weight: .black))
              .tint(.white)
              .padding(.vertical, 15)
              .padding(.horizontal, 40)
              .background(animeCatalogViewModel.selectedAnimeID.isEmpty ? .gray : .appPink)
              .clipShape(.capsule)
          }
                          .disabled(animeCatalogViewModel.selectedAnimeID.isEmpty)
          
          Button {
            animeCatalogViewModel.clearSelectedIDs()
          } label: {
            Image(systemName: "trash")
              .resizable()
              .frame(width: 30, height: 30)
              .tint(animeCatalogViewModel.selectedAnimeID.isEmpty ? Color(.darkGray) : .white)
              .padding(.vertical, 15)
              .padding(.horizontal, 40)
              .background(animeCatalogViewModel.selectedAnimeID.isEmpty ? .gray : .appPink)
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
