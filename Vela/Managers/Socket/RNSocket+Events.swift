//
//  RNSocket+Events.swift
//  TradeLink
//
//  Created by Robert Canton on 2021-01-16.
//

import Foundation
import SocketIO

extension RNSocketManager {
    
    struct SocketAuthRequest:Codable {
        let uid:String
        let token:String
    }
    enum Emittable {
        case msg(_ msg:String)
        case joinRoom(_ roomID:String)

        var data:(String, SocketData) {
            switch self {
            case .msg(let msg):
                return ("msg", msg)
            case .joinRoom(let roomID):
                return ("joinRoom", roomID)
            }
        }
    }

    enum Event {
        case msg
        case priceChange(_ item:AssetPair)
        case newTransaction
        case walletTransaction
        case exchangeTransaction
        
        var name:String {
            switch self {
            case .msg:
                return "msg"
            case .newTransaction:
                return "newTransaction"
            case .priceChange(let assetPair):
                return assetPair.pythID
            case .walletTransaction:
                return "walletTransaction"
            case .exchangeTransaction:
                return "exchangeTransaction"
            }
        }
    }

}
