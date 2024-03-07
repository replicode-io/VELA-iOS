//
//  AssetRow.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-03.
//

import Foundation
import SwiftUI

struct AssetRow: View {
    @Environment(\.theme) var theme
    @ObservedObject var assetPair:AssetPair
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            Image(assetPair.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(assetPair.name)
                    .frame(width: 96, alignment: .leading)
            }
            
//            Text(assetPair.type.)
            
            Spacer(minLength: 0)
            
            VStack(alignment: .trailing, spacing: 2) {
                
                if let price = assetPair.price {
                    Text("\(price)")
                        .foregroundStyle(theme.primary)
                } else {
                    Text("-")
                        .foregroundStyle(theme.secondary)
                }
                
            }

            
        }
    }
    
}
