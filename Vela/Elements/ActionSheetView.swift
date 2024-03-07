//
//  ActionSheetView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-08.
//

import Foundation
import SwiftUI

struct ActionSheetItem {
    let title:String
    let iconName:String
    let color:Color
    let action:()->()
    
    init(title: String, iconName: String, color: Color, action: @escaping () -> Void) {
        self.title = title
        self.iconName = iconName
        self.color = color
        self.action = action
    }
}

struct ActionSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.theme) var theme
    
    static let itemHeight:CGFloat = 48
    
    static func getHeight(for numItems:Int) -> CGFloat {
        return itemHeight * CGFloat(numItems) + 32
    }
    
    let items:[ActionSheetItem]
    
    var body: some View {
        VStack {
            ForEach(0..<items.count, id: \.self) { i in
                let item = items[i]
                Button(action: {
                    item.action()
                    dismiss()
                }) {
                    HStack(alignment: .center, spacing: 12) {
                        
                        Image(systemName: item.iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text(item.title)
                            .font(.system(size: 18, weight: .semibold))
                        
                        Spacer(minLength: 0)
                    }
                    .frame(height: Self.itemHeight)
                    .foregroundStyle(item.color)
                    .padding(.horizontal, 32)
                }
            }
        }
        .padding(.vertical, 16)
        .presentationDetents([.height(Self.getHeight(for: items.count))])
    }
}
