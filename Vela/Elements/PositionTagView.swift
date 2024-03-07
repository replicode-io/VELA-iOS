//
//  PositionTagView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-13.
//

import Foundation
import SwiftUI

struct PositionTagView: View {
    
    @Environment(\.theme) var theme
    
    let direction:PositionDirection
    
    init(_ direction: PositionDirection) {
        self.direction = direction
    }
    
    var body: some View {
        TagView(direction.rawValue.uppercased())
    }
}
