//
//  Theme.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-07.
//

import Foundation
import SwiftUI

public struct Theme {
    public let accent:Color
    public let secondaryAccent:Color
    public let primary:Color
    public let secondary:Color
    public let background:Color
    public let border:Color
    public let fill:Color
    public let positive:Color
    public let negative:Color
    
    public init(
        accent:Color,
        secondaryAccent:Color,
        primary:Color, 
        secondary:Color,
        background:Color,
        border:Color,
        fill:Color,
        positive:Color,
        negative:Color
    ) {
        self.accent = accent
        self.secondaryAccent = secondaryAccent
        self.primary = primary
        self.secondary = secondary
        self.background = background
        self.border = border
        self.fill = fill
        self.positive = positive
        self.negative = negative
    }
    
    func color(for value:BDouble?=nil) -> Color {
        guard let value = value else {
            return secondary
        }
        if value.isZero() {
            return secondary
        } else if value.isPositive() {
            return positive
        } else {
            return negative
        }
    }
    
    func color(for value:Double?=nil) -> Color {
        guard let value = value else {
            return secondary
        }
        if value.isZero {
            return secondary
        } else if value > 0 {
            return positive
        } else {
            return negative
        }
    }
}


public struct ThemeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: Theme = .init(
        accent: .pink,
        secondaryAccent: .pink,
        primary: .pink,
        secondary: .pink,
        background: .pink,
        border: .pink,
        fill: .pink,
        positive: .pink,
        negative: .pink
    )
}

extension EnvironmentValues {
    public var theme: Theme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}

