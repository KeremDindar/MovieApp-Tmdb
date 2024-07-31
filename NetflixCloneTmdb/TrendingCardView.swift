//
//  TrendingCardView.swift
//  NetflixCloneTmdb
//
//  Created by Kerem on 8.07.2024.
//

import SwiftUI

struct TrendingCardView: View {
    
    let trendingItem: TrendingItem
    
    var body: some View {
        ZStack {
            AsyncImage(url: trendingItem.backdropUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150,height: 200)
                    .clipped()
                    
                    
                    
                    
                
            } placeholder: {
                ProgressView()
            }
            .padding(.horizontal)
        }
        
        }
}

#Preview {
    TrendingCardView(trendingItem: .preview)
}
