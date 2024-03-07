//
//  TriggerOrderRow.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-18.
//

import Foundation
import SwiftUI

struct TriggerOrderRow: View {
    
    @Environment(\.theme) var theme
    
    let order:TriggerOrder
    @ObservedObject var assetPair:AssetPair
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            AssetLeverageView(assetPair: assetPair, leverage: String(format: "%.2fx", order.leverage))
            
            TagView(order.isLong ? "LONG" : "SHORT")
            
            TagView(order.isTP ? "TAKE PROFIT" : "STOP LOSS")
            
            Spacer(minLength: 0)
            
            VStack(alignment: .trailing, spacing: 2) {
                
                ForEach(0..<order.parameters.count, id: \.self) { i in
                    let param = order.parameters[i]
                    HStack(alignment: .center, spacing: 6) {
                        Text(param.value)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundStyle(theme.primary)
                        
                        Text(param.key)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundStyle(theme.secondary)
                    }
                }
                
            }
            
        }
        .padding(12)
        .contentShape(Rectangle())
    }
}
