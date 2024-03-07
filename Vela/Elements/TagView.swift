//
//  TagView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-19.
//

import Foundation
import SwiftUI

struct TagView: View {
    
    @Environment(\.theme) var theme
    
    let title:String
    let color:Color?
    let font:Font?
    
    init(_ title: String, color:Color?=nil, font:Font?=nil) {
        self.title = title
        self.color = color
        self.font = font
    }
    
    var body: some View {
        Text(title.uppercased())
            .font(font)
            .foregroundStyle(color ?? theme.secondaryAccent)
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(color ?? theme.secondaryAccent)
                    .opacity(0.15)
            )
    }
}

