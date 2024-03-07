//
//  ClosedPositionView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-10.
//

import Foundation
import SwiftUI

struct ClosedPositionRow: View {
    
    @Environment(\.theme) var theme
    
    let position:ClosedPositon
    let leverageStr:String
    let realisedPnlStr:String
    let totalROI:BDouble?
    let totalROIStr:String
    
    @ObservedObject var assetPair:AssetPair
    
    init(position: ClosedPositon, assetPair: AssetPair) {
        self.position = position
        self.leverageStr = "\(position._leverage?.decimalExpansion(precisionAfterDecimalPoint: 2, rounded: false) ?? "0.00")x"
        self.realisedPnlStr = position._realisedPnL?.decimalExpansion(precisionAfterDecimalPoint: 2, rounded: false) ?? "-"
        self.totalROI = position._totalROI
        self.totalROIStr = totalROI?.decimalExpansion(precisionAfterDecimalPoint: 2, rounded: false) ?? "-"
        self.assetPair = assetPair
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            AssetLeverageView(
                assetPair: assetPair,
                leverage: leverageStr
            )
            
            TagView(position.isLong ? "LONG" : "SHORT")
            
            Spacer(minLength: 0)
            
            VStack(alignment: .trailing, spacing: 2) {
                
                Text(realisedPnlStr)
                    .foregroundStyle(theme.color(for: totalROI))
                
                Text(totalROIStr)
                    .foregroundStyle(.secondary)
                
            }
            
            
        }
        .padding(12)
        .contentShape(Rectangle())
    }
}
