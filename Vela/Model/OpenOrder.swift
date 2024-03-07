//
//  OpenOrder.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-18.
//

import Foundation

enum PositionType:String, Identifiable {
    case market = "Market Order"
    case limit = "Limit Order"
    case stopMarket = "Stop Market"
    case stopLimit = "Stop Limit"
    
    var id:String {
        return rawValue
    }
    
    var displayName:String {
        switch self {
        case .market:
            return ""
        case .limit:
            return "Limit"
        case .stopMarket:
            return "Stop Market"
        case .stopLimit:
            return "Stop Limit"
        }
    }
}

protocol OpenOrder: Codable {
    
//    var id:String { get }
//    var id:String {
//        return posId
//    }
    
    var size: String { get }
//    var pendingCollateral: String { get }
    var collateral: String { get }
    var posId: String { get }
    
    var averagePrice: String { get }
    var accruedPositionFee: String { get }
    var accruedFundingFee: String { get }
    var accruedBorrowFee: String { get }
    
    var paidPositionFee: String { get }
    var paidFundingFee: String { get }
    var paidBorrowFee: String { get }
    
    var tokenId: Int { get }
    var isLong: Bool { get }
    var owner: String { get }
    var refer: String { get }
    
    var leverage: Double { get }
    var createdAt: Int { get }
    
    var status: String { get }
    var chainId: String { get }
    
    
}
