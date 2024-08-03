//
//  StartView.swift
//  NetflixCloneTmdb
//
//  Created by Kerem on 3.07.2024.
//

import SwiftUI

struct StartView: View {
    
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @State var text: String = "Tudo sobre filmes,\n séries, animes e muito mais."
    
    var attributedString: AttributedString {
        var attrS = AttributedString(text)
            
        if let range = attrS.range(of: "Tudo sobre") {
            attrS[range].font = .headline
            attrS[range].font = .system(size: 30)
            
        }
       
        return attrS
    }
    
    var body: some View {
        let attributed = attributedString
        
        
        NavigationStack {
            ZStack {
                Image("start")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.6)]), startPoint: .center, endPoint: .bottom)
                
                
                GeometryReader { geometry in
                    VStack {
                        VStack(alignment: .leading) {
                            Spacer().frame(height: geometry.size.height * 0.5)
                            
                            Text("THE MOVIE DB")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                                .bold()
                                .padding([.trailing,.bottom])
                            
                            Text(attributed)
                                .foregroundStyle(.white)
                                .bold()
                                .font(.largeTitle)
                            Text("Fique por dentro das informações de filmes, séries, animes e muito mais.")
                                .foregroundStyle(.white)
                            
                                .font(.headline)
                                .padding(.top)
                            
                            
                            
                            
                        }
                        VStack {
                            
                            NavigationLink(destination: HomeView(),isActive: $hasSeenOnboarding) {
                                Button {
                                    hasSeenOnboarding = true
                                }
                            label: {
                                Text("Acessar")
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.purple1, Color.purple2]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(25)
                                    .padding([.leading,.trailing,.top])
                                
                            }
                                
                                
                            }
                            
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    StartView()
}
