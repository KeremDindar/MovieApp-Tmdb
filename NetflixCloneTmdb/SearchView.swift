//
//  SearchView.swift
//  NetflixCloneTmdb
//
//  Created by Kerem on 12.07.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = MovieTrendingViewModel()
    @State var searchField: String = ""
    
    var filteredMovies: [TrendingItem] {
        if searchField.count >= 3 {
            let filteredMovies = viewModel.trendingMovies.filter {
                $0.displayTitle.localizedCaseInsensitiveContains(searchField)
            }
            let filteredSeries = viewModel.trendingSeries.filter {
                $0.displayTitle.localizedCaseInsensitiveContains(searchField)
            }
            return filteredMovies + filteredSeries
        } else {
            return viewModel.trendingMovies + viewModel.trendingSeries
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.purple2, Color.black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    TextField("Search", text: $searchField)
                        .padding()
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 20)
                            .fill(Color.purple2))
                    ScrollView {
                        ForEach(filteredMovies) { trendingItem in
                            NavigationLink {
                                DetailView(trendingItem: trendingItem)
                            } label: {
                                SearchCardView(trendingItem: trendingItem)
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadTrendingMovies()
                    await viewModel.loadTrendingSeries()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton(title: "")
            }
        }
    }
}

#Preview {
    SearchView()
}
