//
//  AnimeCatalogView.swift
//  AnimeMatch
//
//  Created by anikin02 on 22.09.2024.
//

import SwiftUI

struct AnimeCatalogView: View {
  
  @State var searchText = String()
  
  var body: some View {
    ZStack {
      VStack {
        // MARK: Search
        HStack {
          Image(systemName: "magnifyingglass")
          TextField("Search...", text: $searchText)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(Color(.systemGray6))
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal, 20)
        
        // MARK: Items
        ScrollView {
          HStack(spacing: 20) {
            AnimeCatalogItemView(nameText: "Ansatsu Kyoushitsu", score: "8.08")
            AnimeCatalogItemView(nameText: "Ansatsu Kyoushitsu", score: "8.08")
          }
          HStack(spacing: 20) {
            AnimeCatalogItemView(nameText: "Ansatsu Kyoushitsu", score: "8.08")
            AnimeCatalogItemView(nameText: "Ansatsu Kyoushitsu", score: "8.08")
          }
          HStack(spacing: 20) {
            AnimeCatalogItemView(nameText: "Ansatsu Kyoushitsu", score: "8.08")
            AnimeCatalogItemView(nameText: "Ansatsu Kyoushitsu", score: "8.08")
          }
          NavigationStack {
            
          }
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

struct AnimeCatalogItemView: View {
  var nameText: String
  var score: String
  
  @State var isSelected = false
  
  var body: some View {
    VStack(alignment: .leading) {
      Image("testImage")
        .resizable()
        .frame(height: 225)
      Text(nameText)
        .font(.system(size: 17, weight: .heavy))
        .lineLimit(nil)
        .multilineTextAlignment(.leading)
        .frame(alignment: .leading)
      HStack(spacing: 2) {
        Image(systemName: "star.circle.fill")
          .foregroundStyle(.green)
        Text(score)
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
