//
//  OpenOrder.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-09.
//

import Foundation

struct PendingOrder: OpenOrder {
    
    let size: String
    let pendingSize: String
    let pendingCollateral: String
    let collateral: String
    let posId: String
    let averagePrice: String
    let accruedPositionFee: String
    let accruedFundingFee: String
    let accruedBorrowFee: String
    let tokenId: Int
    let isLong: Bool
    let owner: String
    let paidPositionFee: String
    let paidFundingFee: String
    let paidBorrowFee: String
    let closingFee: Double
    let refer: String
    let leverage: Double
    let createdAt: Int
    let positionType: String
    let lmtPrice: String
    let stpPrice: String
    let positionStatus: String
    let status: String
    let chainId: String
    
    var _positionType:PositionType? {
        return PositionType(rawValue: positionType)
    }
    
    var primaryValueStr:String {
        return "123"
    }
    
    var secondaryValueStr:String {
        return "456"
    }
    
    var parameters:[OrderParameter] {
        switch _positionType {
        case .limit:
            return [
                .init(key: "LP", value: lmtPrice)
            ]
        case .stopMarket:
            return [
                .init(key: "SP", value: stpPrice)
            ]
        case .stopLimit:
            return [
                .init(key: "LP", value: lmtPrice),
                .init(key: "SP", value: stpPrice)
            ]
        default:
            return []
        }
    }
    
}
