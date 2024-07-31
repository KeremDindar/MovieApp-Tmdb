//
//  DetailView.swift
//  NetflixCloneTmdb
//
//  Created by Kerem on 10.07.2024.
//

import SwiftUI
import AVKit

struct DetailView: View {
    
    let trendingItem: TrendingItem
    
    @StateObject private var viewModel = MovieTrendingViewModel()
    @State var isClicked: Bool = false
    @State private var showSafari = false
    @State private var videoURL: URL?
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(.black).opacity(0.9).edgesIgnoringSafeArea(.all)
                
                //                Spacer().frame(height: 100)
                
                
                
                
                //                .ignoresSafeArea()
                
                ScrollView {
                    GeometryReader { geo in
                        VStack {
                            AsyncImage(url: trendingItem.backdropUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geo.size.width,height: 400)
                            } placeholder: {
                                ProgressView()
                            }
                            Spacer()
                        }
                        .frame(width: geo.size.width, height: geo.size.height) // Tam ekran boyutu verir
                        .ignoresSafeArea(edges: .top)
                    }
                    
                    
                    VStack {
                        Spacer().frame(height: 250)
                        Text(trendingItem.displayTitle)
                            .font(.title)
                            .foregroundStyle(.white)
                        HStack {
                            Text(trendingItem.displayReleaseDate)
                                .foregroundStyle(.white)
                            Text("(\(trendingItem.original_language.uppercased()))")
                                .foregroundStyle(.white)
                        }
                        Text(trendingItem.overview)
                            .foregroundStyle(.white)
                            .padding()
                        Button {
                            Task {
                                if trendingItem.media_type == .movie {
                                    await viewModel.loadMoviesVideos(movieId: trendingItem.id)
                                } else {
                                    await viewModel.loadSeriesVideos(seriesId: trendingItem.id)
                                }
                                
                                if let trailerURL = viewModel.trailerURL {
                                    videoURL = trailerURL
                                    if let url = videoURL {
                                        await UIApplication.shared.open(url)
                                    }
                                }
                            }
                        } label: {
                            Text("Watch Trailer")
                                .frame(width: 300,height: 40)
                                .foregroundColor(.white)
                                .background(Color.purple1)
                                .cornerRadius(20)
                            
                        }
                        
                        
                        HStack {
                            Text("Main Cast")
                                .font(.headline)
                                .foregroundStyle(.white)
                            Spacer()
                            
                        }
                        .padding(.top)
                        
                        if !viewModel.castMembers.isEmpty {
                            
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(viewModel.castMembers) { castMember in
                                        VStack {
                                            if let profileUrl = castMember.profileUrl {
                                                AsyncImage(url: profileUrl) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 80, height: 120)
                                                        .clipShape(Circle())
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                            } else {
                                                Image("placeholder")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                
                                                    .frame(width: 80, height: 100)
                                                    .clipShape(Circle())
                                            }
                                            
                                            Text(castMember.name)
                                                .font(.caption)
                                                .foregroundStyle(.white)
                                                .frame(width: 100)
                                                .multilineTextAlignment(.center)
                                            
                                            Text(castMember.character)
                                                .font(.caption2)
                                                .foregroundColor(.white)
                                                .frame(width: 100)
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("No cast information available")
                                .foregroundStyle(.white)
                                .padding()
                        }
                        HStack {
                            Text("Recommendations")
                                .foregroundStyle(.white)
                                .font(.headline)
                            Spacer()
                        }
                        
                        
                        
                    }
                    VStack {
                        ScrollView(.horizontal) {
                            HStack {
                                if trendingItem.media_type == .movie {
                                    ForEach(viewModel.recMovie) { movie in
                                        NavigationLink {
                                            DetailView(trendingItem: movie)
                                        } label: {
                                            TrendingCardView(trendingItem: movie)
                                        }
                                    }
                                } else {
                                    ForEach(viewModel.recSeries) { series in
                                        NavigationLink {
                                            DetailView(trendingItem: series)
                                        } label: {
                                            TrendingCardView(trendingItem: series)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton( title: trendingItem.displayTitle)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isClicked.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.4)) // Dairenin rengini ayarlar
                                .frame(width: 40, height: 40) // Dairenin boyutunu ayarlar
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(isClicked ? Color.red : Color.white) //
                        }
                        .frame(width: 50, height: 50) 
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadMovieCredits(movieId: trendingItem.id)
                    if trendingItem.media_type == .movie {
                        await viewModel.loadMovieRec(movieId: trendingItem.id)
                    } else {
                        
                        await viewModel.loadSeriesRecommendations(seriesId: trendingItem.id)
                    }
                    
                }
            }
        }
        
    }
}

#Preview {
    DetailView(trendingItem: .preview)
}



