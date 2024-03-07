//
//  TriggerOrder.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-18.
//

import Foundation

struct TriggerOrder: OpenOrder {
//    var id = UUID().uuidString
    
    let orderId: Int
    let size: String
//    let pendingCollateral: String
    let collateral: String
    let posId: String
    let positionType: String
    let averagePrice: String
    let accruedPositionFee: String
    let accruedFundingFee: String
    let accruedBorrowFee: String
    let paidPositionFee: String
    let paidFundingFee: String
    let paidBorrowFee: String
    let tokenId: Int
    let isLong: Bool
    let owner: String
    let refer: String
    let createdAt: Int
    let leverage: Double
    let isTP: Bool
    let amountPercent: String
    let triggerPrice: String
    let triggeredAmount: String
    let triggerCreatedAt: Int
    let triggeredAt: Int
    let triggerStatus: String
    let status: String
    let chainId: String

    var parameters:[OrderParameter] {
        
        if isTP {
            return [
                .init(key: "TP", value: String(format: "%.2f", Double(triggerPrice) ?? 0)),
                .init(key: "TP", value: amountPercent)
            ]
        } else {
            return [
                .init(key: "SL", value: String(format: "%.2f", Double(triggerPrice) ?? 0)),
                .init(key: "%", value: amountPercent)
            ]
        }
    }
}
