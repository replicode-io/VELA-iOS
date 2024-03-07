//
//  OpenPosition.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-02.
//

import Foundation

struct OpenPosition: Codable, Identifiable {
    
    var id: String {
        return posId
    }
    
    let size: String
    let collateral: String
    let posId: String
    let liquidationPrice: Double?
    let pendingCollateral: String
    let averagePrice: String
    let accruedPositionFee: String
    let accruedFundingFee: String
    let accruedBorrowFee: String
    let fundingIndex: FundingIndex
    let tokenId: Int
    let paidPositionFee: String
    let paidBorrowFee: String
    let paidFundingFee: String
    let closingFee: Int
    let isLong: Bool
    let owner: String
    let refer: String
    let leverage: Double
    let createdAt: Int
    let positionType: String
    let lmtPrice: String
    let positionStatus: String
    let status: String
    let chainId: String
    
    var _size:BDouble? {
        return BDouble(size)
    }
    
    var _averagePrice:BDouble? {
        return BDouble(averagePrice)
    }
    
    var _accruedPositionFee:BDouble? {
        return BDouble(accruedPositionFee)
    }
    
    var _accruedFundingFee:BDouble? {
        return BDouble(accruedFundingFee)
    }
    
    var _accruedBorrowFee:BDouble? {
        return BDouble(accruedBorrowFee)
    }
    
    var _paidPositionFee:BDouble? {
        return BDouble(paidPositionFee)
    }
    
    var _paidFundingFee:BDouble? {
        return BDouble(paidFundingFee)
    }
    
    var _paidBorrowFee:BDouble? {
        return BDouble(paidBorrowFee)
    }
    
    var _lmtPrice:BDouble? {
        return BDouble(lmtPrice)
    }
    
    var _collateral:BDouble? {
        return BDouble(collateral)
    }
    
    var _pendingCollateral:BDouble? {
        return BDouble(pendingCollateral)
    }
}

struct FundingIndex:Codable {
    let type: String
    let hex: String
}

extension OpenPosition {
    func uPnL(for markPrice:BDouble) -> BDouble {
        let size = _size ?? 0
        let averagePrice = _averagePrice ?? 0
        let positionSize = size / averagePrice
        
        if isLong {
            let value = (markPrice - averagePrice) * positionSize
            return value
        } else {
            let value = (averagePrice - markPrice) * positionSize
            return value
        }
    }
    
    func uPnL(for markPrice:Double) -> Double {
        let size = Double(size) ?? 0
        let averagePrice = Double(averagePrice) ?? 0
        let positionSize = size / averagePrice
        
        let accruedFees = (Double(accruedPositionFee) ?? 0) + (Double(accruedFundingFee) ?? 0) + (Double(accruedBorrowFee) ?? 0)
        
        if isLong {
            let value = (markPrice - averagePrice) * positionSize //- accruedFees
            return value
        } else {
            let value = (averagePrice - markPrice) * positionSize //- accruedFees
            return value
        }
    }
    
    
    func netValue(for uPnL:BDouble) -> BDouble {
        let collateral = _collateral ?? 0
        return collateral + uPnL
    }
    
    func netValue(for uPnL:Double) -> Double {
        let collateral = Double(collateral) ?? 0
        return collateral + uPnL
    }
    
    var dateStr:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date = Date(timeIntervalSince1970: TimeInterval(createdAt))
        return formatter.string(from: date)
    }
}
