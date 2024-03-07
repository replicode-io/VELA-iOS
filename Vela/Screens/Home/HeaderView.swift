//
//  HeaderView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-10.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    
    @Environment(\.theme) var theme
    
    let title:String
    let count:Int
    @Binding var toggle:Bool
    
    
    var body: some View {
        Button(action: {
            withAnimation {
                toggle.toggle()
            }
        }) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .foregroundStyle(!toggle ? theme.primary : theme.secondary)
                        .foregroundStyle(theme.secondary)
                    
                    Text("\(count)")
                        .foregroundStyle(!toggle ? theme.primary : theme.secondary)
                        .frame(height: 28)
                        .padding(.horizontal, 10)
                        .background(
                            Capsule()
                                .fill(theme.fill.opacity(2/3))
                        )
                        .padding(.horizontal, 12)
                        .opacity(count > 0 ? 1 : 0)
                    
                    Spacer(minLength: 8)
//                    
                    Button(action: {
                        withAnimation {
                            toggle.toggle()
                        }
                    }) {
                        Image("sort")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(theme.secondary)
                            .rotationEffect(.degrees(toggle ? -90 : 0))
                    }
                }
                
                Divider()
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 8)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
