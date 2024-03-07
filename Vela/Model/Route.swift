//
//  HomeRoute.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-08.
//

import Foundation

enum Route: Identifiable, Hashable {
    case portfolio(_ portfolio:Portfolio)
    
    var id:String {
        switch self {
        case .portfolio(let portfolio):
            return "portfolio:\(portfolio.id)"
        }
    }
    
    public func hash(into hasher: inout Hasher) {
           return hasher.combine(id)
       }
       
}
