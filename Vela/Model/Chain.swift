//
//  Chain.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-14.
//

import Foundation

enum Chain:String, Identifiable {
    case arbitrum = "42161"
    case base = "8453"
    
    var id:String {
        return self.rawValue
    }
    
    var displayName:String {
        switch self {
        case .arbitrum:
            return "Arbitrum"
        case .base:
            return "Base"
        }
    }
}
