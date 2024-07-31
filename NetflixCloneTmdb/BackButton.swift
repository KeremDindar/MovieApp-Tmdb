//
//  backButton.swift
//  NetflixCloneTmdb
//
//  Created by Kerem on 12.07.2024.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    var body: some View {
        Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            
                            .foregroundColor(Color.white)
                        Text(title)
                            .foregroundStyle(.white)
                    }
                    
                        
                }
    }
}

#Preview {
    BackButton( title: "asd")
}
