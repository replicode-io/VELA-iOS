//
//  PortfolioDTO.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-21.
//

import Foundation


struct PortfolioDTO: Codable {
    let collateralUsage: String
    let marginUsage: String
    let openLongs: String
    let openShorts: String
    let vusdBalance: String
    
    var _vusdBalance:BDouble? {
        BDouble(vusdBalance, over: VELA_DENOMINATOR)
    }
}
