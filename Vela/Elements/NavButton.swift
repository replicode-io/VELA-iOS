//
//  NavButton.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-08.
//

import Foundation
import SwiftUI

struct NavButton: View {
    
    @Environment(\.theme) var theme
    
    let iconName:String
    let color:Color?
    let action:()->()
    
    init(iconName: String, color: Color?=nil, action: @escaping () -> Void) {
        self.iconName = iconName
        self.color = color
        self.action = action
    }
    
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .fontWeight(.medium)
                .frame(width: 16, height: 16)
                .foregroundStyle(color ?? theme.accent)
                .padding(8)
                .background(
                    Circle()
                        .fill((color ?? theme.accent).opacity(0.25))
                )
        }
    }
    
}
