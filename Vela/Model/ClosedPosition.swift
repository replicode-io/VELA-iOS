//
//  ClosedPosition.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-10.
//

import Foundation

struct ClosedPositon:Codable, Identifiable {
    
    var id:String {
        return "closedPosition:\(posId)"
    }
    
    let account: String
    let averagePrice: String
    let collateral: String
    let createdAt: Int
    let closedAt: Int
    let positionFee: String
    let borrowFee: String
    let fundingFee: String
    let tokenId: String
    let isLong: Bool
    let lmtPrice: String
    let markPrice: String
    let orderStatus: String
    let pendingCollateral: String
    let pendingSize: String
    let pendingDelayCollateral: String
    let pendingDelaySize: String
    let posId: String
    let positionStatus: String
    let positionType: String
    let realisedPnl: String
    let totalROI: String
    let totalSize: String
    let totalCollateral: String
    let size: String
    let stpPrice: String
    
    var _tokenId:Int? {
        return Int(tokenId)
    }
    
    var _realisedPnL:BDouble? {
        return BDouble(realisedPnl, over: VELA_DENOMINATOR)
    }
    
    var _totalROI:BDouble? {
        return BDouble(totalROI, over: "1000")
    }
    
    var _totalSize:BDouble? {
        return BDouble(totalSize, over: VELA_DENOMINATOR)
    }
    
    var _totalCollateral:BDouble? {
        return BDouble(totalCollateral, over: VELA_DENOMINATOR)
    }
    
    var _leverage:BDouble? {
        guard let size = _totalSize, let collateral = _totalCollateral else {
            return nil
        }
        return size / collateral
    }
    
}

