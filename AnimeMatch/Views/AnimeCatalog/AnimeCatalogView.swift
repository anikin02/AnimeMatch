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
          Button {
            
          } label: {
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

struct AnimeCatalogItemView: View {
  var animeItem: AnimeCatalogItem
  
  @State var isSelected = false
  
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
          isSelected.toggle()
        } label: {
          Text(isSelected ? "Cancel" : "Select")
            .font(.system(size: 17, weight: .black))
            .tint(.white)
            .padding(.horizontal, 10)
            .background(isSelected ? .gray : .appPink)
            .clipShape(.capsule)
        }
      }
    }
    .frame(width: 160)
  }
}


#Preview {
  AnimeCatalogView()
}
