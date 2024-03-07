//
//  PortfolioCardView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-04.
//

import Foundation
import SwiftUI

struct PortfolioCardView: View {
    @EnvironmentObject var assetManager:AssetManager
    @Environment(\.theme) var theme
    
    @ObservedObject var portfolio:Portfolio
    
    @Binding var path:[Route]
    @Binding var modal:Modal?
    
    
    var body: some View {
        
        let hasPositions = !portfolio.openPositions.isEmpty || !portfolio.pendingOrders.isEmpty
        
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                path.append(.portfolio(portfolio))
            }) {
                HStack(alignment: .center, spacing: 0) {
                    
//                    Circle()
//                        .fill(hasPositions ? theme.positive : theme.fill)
//                        .frame(width: 8, height: 8)
//                        .padding(.leading)
                    
                    Text(portfolio.wallet.displayName)
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
//                        .monospaced()
//                        .padding(.vertical)
//                        .padding(.leading)
                        .foregroundStyle(theme.secondary)
                    
//                    Image("bolt")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 16, height: 16)
//                        .foregroundStyle(theme.accent)
//                        .padding(.horizontal, 8)
//                        .padding(.vertical, 3)
//                        .background(
//                            RoundedRectangle(cornerRadius: 4, style: .continuous)
//                                .fill(theme.accent.opacity(0.15))
//                        )
//                        .padding(.leading, 8)
                    
                    Spacer(minLength: 8)
                    
//                    Button(action: {
//                        withAnimation {
//                            portfolio.isCollapsed.toggle()
//                        }
//                    }) {
//                        Image(systemName: "chevron.right")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 12, height: 12)
//                            .foregroundStyle(.secondary)
//                            .padding()
//                            .contentShape(Rectangle())
//                    }
//                    .buttonStyle(.plain)
                }
                
//                .background(Color.white.opacity(0.1))
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            if !portfolio.isCollapsed && hasPositions{
                Divider()
                
                if !portfolio.openPositions.isEmpty {
                    ForEach(portfolio.openPositions) { position in
                        if let assetPair = assetManager.assets[position.tokenId] {
                            PositionRow(position: position, assetPair: assetPair)
                            Divider()
                        }
                    }
                }
               
            }
            
            
            
        }
//        .clipShape(
//            RoundedRectangle(cornerRadius: 12, style: .continuous)
//        )
//        .background(
//            
//            RoundedRectangle(cornerRadius: 12, style: .continuous)
//                .fill(theme.background)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 12, style: .continuous)
//                        .stroke(Color(uiColor: .separator), lineWidth: 1)
//                )
//        )
        
    }
    
}
