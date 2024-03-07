//
//  RoundedButton.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-22.
//

import Foundation
import SwiftUI

struct RoundedButton:View {
    let title: String
    let count: Int
    let isSelected:Bool
    let action:()->()
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 4) {
                Text(title)
                    .lineLimit(1)
                    .font(.system(size: 13.0, weight: .regular, design: .default))
                    .foregroundColor(isSelected ? Color.primary : Color.secondary)
                    .frame(maxWidth: .infinity, alignment: count > 0 ? .leading : .center)
                
                if count > 0 {
                    Text("\(count)")
                        .lineLimit(1)
                        .font(.system(size: 13.0, weight: .regular, design: .default))
                        .foregroundColor(isSelected ? Color.primary : Color.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.1))
                        )
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, count > 0 ? 8 : 16)
            .frame(height: 36)
            .background(
                RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                    .fill(isSelected ? Color.white.opacity(0.15): Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                            .stroke(Color.white.opacity(0.05), lineWidth: 1)
                            .opacity(isSelected ? 1 : 0)
                    )
            )
        }
        
    }
}

