//
//  PositionRow.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-03.
//

import Foundation
import SwiftUI

struct PositionRow: View {
    
    @Environment(\.theme) var theme
    
    let position:OpenPosition
    @ObservedObject var assetPair:AssetPair
    
    var uPnL:Double? {
        guard let markPrice = assetPair.price else { return nil }
        return position.uPnL(for: markPrice)
    }
    
    var netValue:Double? {
        guard let uPnL = uPnL else { return nil }
        return position.netValue(for: uPnL)
    }
    
    var priceColor:Color {
        guard let uPnL = uPnL else {
            return theme.secondary
        }
        
        if uPnL > 0 {
            return theme.positive
        } else if uPnL < 0 {
            return theme.negative
        } else {
            return theme.secondary
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            AssetLeverageView(assetPair: assetPair, leverage: String(format: "%.2fx", position.leverage))
            
            PositionTagView(position.isLong ? .long : .short)
            
            Spacer(minLength: 0)
            
            VStack(alignment: .trailing, spacing: 2) {
                
                if let uPnL = uPnL {
                    Text(String(format: "%.2f", uPnL))
                        .foregroundStyle(priceColor)
                } else {
                    Text("-")
                        .foregroundStyle(priceColor)
                }
                
                if let netValue = netValue {
                    Text(String(format: "%.2f", netValue))
                        .foregroundStyle(.secondary)
                } else {
                    Text("-")
                        .foregroundStyle(.secondary)
                }
                
            }
            
        }
        .padding(12)
        .contentShape(Rectangle())
    }
}
