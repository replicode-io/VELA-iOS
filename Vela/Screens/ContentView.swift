//
//  ContentView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-02.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.theme) var theme
    @StateObject var viewModel = ContentViewModel()
    @StateObject var assetManager = AssetManager()
    
    @Query private var wallets: [Wallet]
    
    @State var selection = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                HomeView()
                    .tag(0)
                    .tabItem {
                        Image(
                            uiImage: UIImage(systemName: selection == 0 ? "chart.pie.fill" : "chart.pie")!
                        )
                        Text("Dashboard")
                    }
                
                WatchlistView()
                    .tag(1)
                    .tabItem {
                        Image(
                            uiImage: UIImage(systemName: selection == 1 ? "diamond.circle.fill" : "diamond.circle")!
                        )
                        
                        Text("Assets")
                    }
            }
            .tint(theme.primary)
        }
        .environmentObject(assetManager)
        .environmentObject(viewModel)
        .onAppear {
            viewModel.fetch()
            assetManager.startObserving()
        }
    }

}
