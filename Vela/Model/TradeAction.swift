//
//  TradeAction.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-14.
//

import Foundation

let VELA_DENOMINATOR = "1000000000000000000000000000000"
let WEI_TO_ETHER = "1000000000000000000"

struct TradeAction:Codable {
    let actionType: String
    let account: String
    let averagePrice: String
    let tokenId: String
    let collateral: String
    let createdAt: Int
    let positionFee: String
    let fundingFee: String
    let borrowFee: String
    let isLong: Bool
    let isWin: Bool
    let isPlus: Bool
    let markPrice: String
    let posId: String
    let positionType: String
    let profitLoss: String
    let tradeVolume: String
    
    var _averagePrice:BDouble? {
        BDouble(averagePrice, over: VELA_DENOMINATOR)
    }
    
    var _positionFee:BDouble? {
        BDouble(positionFee, over: VELA_DENOMINATOR)
    }
    
    var _fundingFee:BDouble? {
        BDouble(fundingFee, over: VELA_DENOMINATOR)
    }
    
    var _borrowFee:BDouble? {
        BDouble(borrowFee, over: VELA_DENOMINATOR)
    }
    var _markPrice:BDouble? {
        BDouble(markPrice, over: VELA_DENOMINATOR)
    }
    
    var _profitLoss:BDouble? {
        BDouble(profitLoss, over: VELA_DENOMINATOR)
    }
    
    var _tradeVolume:BDouble? {
        BDouble(tradeVolume, over: VELA_DENOMINATOR)
    }
    
    
    init(actionType: String, account: String, averagePrice: String, tokenId: String, collateral: String, createdAt: Int, positionFee: String, fundingFee: String, borrowFee: String, isLong: Bool, isWin: Bool, isPlus: Bool, markPrice: String, posId: String, positionType: String, profitLoss: String, tradeVolume: String) {
        self.actionType = actionType
        self.account = account
        self.averagePrice = averagePrice
        self.tokenId = tokenId
        self.collateral = collateral
        self.createdAt = createdAt
        self.positionFee = positionFee
        self.fundingFee = fundingFee
        self.borrowFee = borrowFee
        self.isLong = isLong
        self.isWin = isWin
        self.isPlus = isPlus
        self.markPrice = markPrice
        self.posId = posId
        self.positionType = positionType
        self.profitLoss = profitLoss
        self.tradeVolume = tradeVolume
        
    }
    
}
