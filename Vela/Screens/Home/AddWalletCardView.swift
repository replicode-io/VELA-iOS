//
//  AddWalletCardView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-10.
//

import Foundation
import SwiftUI

struct AddWalletCardView: View {
    
    @Environment(\.theme) var theme
    

    let action:()->()
    var gradientColors:[Color] {
        return [
            theme.primary.opacity(0.1),//(hex: "005bea"),
            theme.primary.opacity(0.2)//(hex: "00c6fb")
        ]
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .center, spacing: 12) {
                Spacer(minLength: 0)
                Image("plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(theme.secondary)
                
                Text("ADD WALLET")
                    .font(.system(size: 15, weight: .regular))
                    .monospaced()
                    .foregroundStyle(theme.secondary)
                Spacer(minLength: 0)
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(theme.primary.opacity(0.15), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
    }
    
}

