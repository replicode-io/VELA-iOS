//
//  PendingOrderRow.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-09.
//

import Foundation
import SwiftUI

struct PendingOrderRow: View {
    
    @Environment(\.theme) var theme
    
    let order:PendingOrder
    @ObservedObject var assetPair:AssetPair
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            AssetLeverageView(assetPair: assetPair, leverage: String(format: "%.2fx", order.leverage))
            
            TagView(order.isLong ? "LONG" : "SHORT")
                .padding(.leading, 12)
            
            if let positionType = order._positionType {
                TagView(positionType.displayName)
                    .padding(.leading, 12)
            }
            
            Spacer(minLength: 12)
            
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
