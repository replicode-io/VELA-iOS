//
//  CardView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-05.
//

import Foundation
import SwiftUI
import IrregularGradient

struct CardView: View {
    
    @Environment(\.theme) var theme
    
    
    @State var isActive = false
    
    let wallet:Wallet
    @Binding var selectedCard:CardOption?
     
    let action:()->()
    
    var gradientColors:[Color] {
        return [
            Color.primary.opacity(0.05),//(hex: "005bea"),
            Color.primary.opacity(0.15)//(hex: "00c6fb")
        ]
    }
    
    var activeColors:[Color] {
        return CardStyle.all.randomElement()!.colors
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {
                
                
                HStack(alignment: .center, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(wallet.displayName)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(theme.primary)
                        
                        Text(wallet.address.shortAddress.lowercased())
                            .monospaced()
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(theme.primary.opacity(0.5))
                    }
                    
                    Spacer(minLength: 16)
                    
                    Image("ETH_128")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(theme.primary)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(theme.primary.opacity(0.025))
                                .overlay(
                                    Circle()
                                        .stroke(theme.primary.opacity(0.15), lineWidth: 1)
                                )
                        )
                }
                
                Spacer(minLength: 16)
                
                HStack(alignment: .center, spacing: 0) {
                    //                Image("wallet")
                    //                    .resizable()
                    //                    .scaledToFit()
                    //                    .frame(width: 20, height: 20)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(wallet.balance?.decimalExpansion(precisionAfterDecimalPoint: 2, rounded: false) ?? "-")
                            .font(.system(size: 24, weight: .semibold))
                        
                        Text("wallet")
                            .monospaced()
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(theme.primary.opacity(0.5))
                        
                        
                    }
                    
                    Spacer(minLength: 24)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text(wallet.exchangeBalance?.decimalExpansion(precisionAfterDecimalPoint: 2, rounded: false) ?? "-")
                            .font(.system(size: 24, weight: .semibold))
                        
                        Text("exchange")
                            .monospaced()
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(theme.primary.opacity(0.5))
                        
                    }
                    Spacer(minLength: 0)
                    
                }
                
            }
            .padding(24)
            .background(
                
                ZStack {
//                    
//                    BlurView(style: .systemThinMaterialDark)
////                        .opacity(0.25)
                    ///
                    Rectangle()
                    .fill(.clear)
                    .overlay(
                Image("grain")
                    .resizable()
                    .scaledToFill()
                    .blendMode(.screen)
                    .opacity(0.3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea(.all)
                )
                    
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
//                    LinearGradient(
//                        colors: activeColors,
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
//                    .opacity(isActive ? 0.75 : 0)
                    
                    
                }
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(theme.primary.opacity(0.15), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
        .onChange(of: selectedCard) { value in
            let _isActive = value == CardOption.wallet(wallet)
            if _isActive != isActive {
                withAnimation {
                    self.isActive = _isActive
                }
            }
        }
        .onAppear {
            self.isActive = selectedCard == CardOption.wallet(wallet)
        }
    }
    
}

