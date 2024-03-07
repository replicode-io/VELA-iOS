//
//  CloseButton.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-11.
//

import Foundation
import SwiftUI

public struct CloseButton: View {
    
    @Environment(\.theme) var theme
    
    let action:()->()
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .bold()
                .frame(width: 12, height: 12)
                .foregroundColor(theme.secondary)
                .padding(10)
                .background(
                    Circle()
                        .fill(theme.fill)
            
                )
        }
        .buttonStyle(.plain)
    }
}
