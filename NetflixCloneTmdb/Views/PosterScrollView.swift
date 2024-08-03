//
//  PosterScrollView.swift
//  NetflixCloneTmdb
//
//  Created by Kerem on 20.07.2024.
//

import SwiftUI

enum Category: String, CaseIterable {
    
    case filmes = "Filmes"
    case series = "Series"
    case animes = "Animes"
    case novelas = "Novelas"
    
}

struct PosterScrollView: View {
    
    @Binding var trendingItems: [TrendingItem] 
    
    var body: some View {
       
        
            if trendingItems.isEmpty {
                Text("No Results")
                    .frame(height: 200)
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(trendingItems) { trendingItem in
                            NavigationLink {
                                DetailView(trendingItem: trendingItem)
                            } label: {
                                TrendingCardView(trendingItem: trendingItem)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        
        
        
    }
}

