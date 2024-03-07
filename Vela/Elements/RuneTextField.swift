//
//  RuneTextField.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-03.
//

import Foundation
import SwiftUI

struct RuneTextField: View {
    
    @Environment(\.theme) var theme
    
    @Binding var text:String
    let title:String?
    let accessory:String?
    let placeholder:String
    let footer:String?
    
    @FocusState var isFocused:Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            if title != nil || accessory != nil {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    if let title = title {
                        Text(title)
                            .font(.system(size: 13.5, weight: .medium))
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    
                    if let accessory = accessory {
                        Text(accessory)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.secondary)
                            .opacity(0.6)
                    }
                    
                }
            }

            HStack(alignment: .center, spacing: 0) {
                TextField(placeholder, text: $text)
                    .keyboardType(.asciiCapable)
                    .autocorrectionDisabled()
                    .truncationMode(.middle)
                    .textInputAutocapitalization(.never)
                    .focused($isFocused)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                
                Button(action: {
                    text = UIPasteboard.general.string ?? ""
                }) {
                    Image("duplicate")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.secondary)
                        .scaleEffect(x: -1)
                }
                .disabled(!UIPasteboard.general.hasStrings)
                .buttonStyle(.plain)
                .labelStyle(.iconOnly)
                .padding()
            }
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(theme.primary.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(theme.primary.opacity(0.1), lineWidth: 1)
                    )
            )
//            .clipShape(
//                RoundedRectangle(cornerRadius: , style: .continuous)
//            )
//            .onAppear {
//                isFocused = true
//            }
                
            if let footer = footer {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(footer)
                        .font(.system(size: 13))
                        .foregroundStyle(.secondary)
                        .opacity(0.75)
                }
            }
        }
    }
}
