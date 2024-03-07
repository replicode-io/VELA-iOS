//
//  WatchlistView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-03.
//

import Foundation
import SwiftUI


struct WatchlistView: View {
    
    @EnvironmentObject var viewModel:ContentViewModel
    @EnvironmentObject var assetManager:AssetManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        
                        let assetPairs = AssetPair.all
                        ForEach(assetPairs) { assetPair in
                            AssetRow(assetPair: assetPair)
                            
                            Divider()
                            
                        }
                            
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle("Assets")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
