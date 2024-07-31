//
//  SearchCardView.swift
//  NetflixCloneTmdb
//
//  Created by Kerem on 12.07.2024.
//

import SwiftUI

struct SearchCardView: View {
    
    let trendingItem: TrendingItem
    var body: some View {
       
            VStack(alignment: .leading) {
                HStack {
                    Text(trendingItem.displayTitle)
                        .font(.title)
                        .foregroundStyle(.white)

                        .padding()
                    Spacer()
                    Text("IMDB: \(Int(trendingItem.vote_average))")
                        .padding()
                        .font(.system(size: 20))
                                .foregroundColor(.white)
                }
                HStack {
                    AsyncImage(url:trendingItem.backdropUrl) { image in
                        image
                            .resizable()
                            .frame(width: 110,height: 170)
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    
                        Text(trendingItem.overview)
                            .font(.caption)
                            .foregroundStyle(.white)
                      
//                        Spacer()
                    
                    
                }
                .padding(.leading)
               
                
            }
        
    }
}

#Preview {
    SearchCardView( trendingItem: .preview)
}
