//
//  BlurView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-13.
//

import SwiftUI

/// An UIViewRepresentable for the UIBlurEffectView
public struct BlurView: UIViewRepresentable {

    /// The style of the Blut Effect View
    public let style: UIBlurEffect.Style
    
    public init(style: UIBlurEffect.Style = .systemMaterial) {
        self.style = style
    }

    public func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
