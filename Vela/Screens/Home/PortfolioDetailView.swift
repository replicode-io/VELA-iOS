//
//  PortfolioDetailView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-08.
//

import Foundation
import SwiftUI

struct PortfolioDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.theme) var theme
    
    @ObservedObject var portfolio:Portfolio
    
    
    init(portfolio:Portfolio) {
        self.portfolio = portfolio
    }
    
    var body: some View {
        ZStack {
            theme.background
                .ignoresSafeArea(.all)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    Spacer()
                }
            }
        }
        .navigationTitle(portfolio.wallet.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                    
                }
                .buttonStyle(.plain)
                .foregroundStyle(theme.primary)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavButton(iconName: "gearshape.fill") {
                    dismiss()
                }
            }
        }
    }
}
