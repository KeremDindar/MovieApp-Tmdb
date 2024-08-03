//
//  HomeView.swift
//  NetflixCloneTmdb
//
//  Created by Kerem on 3.07.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var search: String = ""
    @StateObject var viewModel = MovieTrendingViewModel()
    @State var category: [Category] = Category.allCases
    @State var selectedCategory: Category = .filmes
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.purple2, Color.black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    HStack {
                        Text("What do you want to watch today?")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .padding()
                        Spacer()
                        Image("profile")
                            .resizable()
                            .frame(maxWidth: 60, maxHeight: 60)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                    
                    NavigationLink {
                        SearchView()
                    } label: {
                        TextField("", text: $search, prompt: Text("Search"))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.purple2))
                    
                    VStack {
                        ScrollView {
                            HStack {
                                ForEach(category, id: \.self) { cat in
                                    Text(cat.rawValue)
                                        .font(.headline)
                                        .padding()
                                        .background(selectedCategory == cat ? Color.pink : Color.clear)
                                        .cornerRadius(30)
                                        .foregroundColor(selectedCategory == cat ? .white : .gray)
                                        .onTapGesture {
                                            selectedCategory = cat
                                        }
                                }
                            }
                            
                            if selectedCategory == .filmes {
                                
                                PosterScrollView(trendingItems: $viewModel.trendingMovies)
                                
                            } else if selectedCategory == .series {
                                PosterScrollView(trendingItems: $viewModel.trendingSeries)
                            }
                            
                            VStack {
                                ScrollView {
                                    HStack {
                                        Text("More Popular")
                                            .font(.title)
                                            .foregroundStyle(.white)
                                            .padding(.leading)
                                        Spacer()
                                    }
                                }
                                if selectedCategory == .filmes {
                                   
                                    PosterScrollView(trendingItems: $viewModel.popularMovies)

                                } else if selectedCategory == .series {
                                    
                                   
                                    PosterScrollView(trendingItems: $viewModel.popularSeries)
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
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}


#Preview {
    HomeView()
}



