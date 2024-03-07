//
//  AssetLeverageView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-19.
//

import Foundation
import SwiftUI

struct AssetLeverageView: View {
    
    @ObservedObject var assetPair:AssetPair
    let leverage:String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(assetPair.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    if assetPair.base == "CAD", assetPair.symbol == "USD" {
                        Text(assetPair.base)
                    } else {
                        Text(assetPair.symbol)
                    }
                }
                
                Text(leverage)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }
            
        }
        .frame(width: 36+12+48+8, alignment: .leading)
    }
    
}
