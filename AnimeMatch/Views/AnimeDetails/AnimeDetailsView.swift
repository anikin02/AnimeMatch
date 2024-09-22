//
//  AnimeDetailsView.swift
//  AnimeMatch
//
//  Created by anikin02 on 22.09.2024.
//

import SwiftUI

struct AnimeDetailsView: View {
  @State var genres = ["Shounen", "Action", "Comedy", "School"]
  var score = 8.33
  
  var body: some View {
    VStack {
      ScrollView {
        VStack {
          Image("testImage")
            .resizable()
            .frame(width: 225, height: 331)
          Text("Ansatsu Kyoushitsu")
            .font(.system(size: 30, weight: .black))
          Text("Assassination Classroom")
            .font(.system(size: 20, weight: .bold))
          HStack {
            ForEach(0..<5, id: \.self) { counterStar in
              Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(Int(score/2) > Int(counterStar) ? .appPink : .gray)
                .frame(width: 24, height: 24)
            }
            Text(String(score))
              .font(.system(size: 22))
          }
        }
        
        VStack(alignment: .leading) {
          Text("Kind: TV")
            .font(.system(size: 18))
          let genresText = genres.joined(separator: ", ")
          Text("Genres: \(genresText)")
            .font(.system(size: 18))
        }
        
        VStack(alignment: .leading) {
          Text("Secreanshots")
            .font(.system(size: 20))
        }
      }
      .scrollIndicators(.hidden)
      .padding(.top)
    }
    .padding(.horizontal, 20)
  }
}

#Preview {
  AnimeDetailsView()
}
