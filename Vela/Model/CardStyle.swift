//
//  CardStyle.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-13.
//

import Foundation
import SwiftUI

struct CardStyle:Identifiable {
    let id:String
    let hexes:[String]
    let colors:[Color]
    
    init(_ hexes: [String]) {
        var str = ""
        var colors = [Color]()
        for hex in hexes {
            str += hex
            colors.append(Color(hex: hex))
        }
        self.id = str
        self.hexes = hexes
        self.colors = colors
    }
    
    static let all:[CardStyle] = [
        .init(["EEBD89", "D13ABD"]),
        .init(["9600FF", "AEBAF8"]),
        .init(["F6EA41", "F048C6"]),
        .init(["BB73E0", "FF8DDB"]),
        .init(["0CCDA3", "C1FCD3"]),
        .init(["9600FF", "AEBAF8"]),
        .init(["C973FF", "AEBAF8"]),
        .init(["F9957F", "F2F5D0"]),
        .init(["B60F46", "D592FF"]),
        .init(["A3C9E2", "9618F7"]),
        .init(["FF0078", "F6EFA7"]),
        .init(["849B5C", "BFFFC7"]),
        .init(["E5AAC3", "9A52C7"]),
        .init(["E65758", "771D32"]),
        .init(["EF33B1", "F6E6BC"]),
        .init(["C22ED0", "5FFAE0"]),
        .init(["9FA5D5", "E8F5C8"]),
        .init(["0C7BB3", "F2BAE3"]),
        .init(["07A3B2", "D9ECC7"]),
        .init(["CCFBFF", "EF96C5"]),
        .init(["50D5B7", "067D68"]),
        .init(["A96F44", "F2ECB6"]),
        .init(["AF6480", "C3CEE5"]),
        .init(["EAD6EE", "A0F1EA"]),
        .init(["EAE5C9", "6CC6CB"]),
        .init(["ED765E", "FEA858"]),
        .init(["9600FF", "AEBAF8"])
    ]
}
