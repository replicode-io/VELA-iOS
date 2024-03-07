//
//  AssetPair.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-03.
//

import Foundation

enum AssetType:String, Identifiable, Codable {
    case crypto = "Crypto"
    case forex = "Forex"
    case metal = "Metal"
    
    var code:String {
        switch self {
        case .crypto:
            return "Crypto"
        case .forex:
            return "FX"
        case .metal:
            return "Metal"
        }
    }
    
    var id:String {
        return rawValue
    }
    
}

class AssetPair:ObservableObject, Identifiable {
    let id:Int // VELA ID
    let symbol:String
    let base:String
    let type: AssetType
    
    @Published var price:Double?
    
    
    init(id: Int, symbol: String, base: String, type: AssetType, price: Double?=nil) {
        self.id = id
        self.symbol = symbol
        self.base = base
        self.type = type
        self.price = price
    }
    
    var name:String {
        return "\(symbol)/\(base)"
    }
    
    var imageName:String {
        return "\(type.rawValue)_\(symbol)_\(base)".uppercased()
    }
    
    var pythID:String {
        return "\(type.code).\(name)"
    }
    
    static let all:[AssetPair] = [
        .init(id: 1, symbol: "BTC", base: "USD", type: .crypto),
        .init(id: 2, symbol: "ETH", base: "USD",  type: .crypto),
        .init(id: 3, symbol: "LTC", base: "USD",  type: .crypto),
        .init(id: 4, symbol: "ADA", base: "USD",  type: .crypto),
        .init(id: 5, symbol: "DOGE", base: "USD",  type: .crypto),
        .init(id: 6, symbol: "SHIB", base: "USD",  type: .crypto),
        .init(id: 7, symbol: "ARB", base: "USD", type: .crypto),
        .init(id: 8, symbol: "SOL", base: "USD",  type: .crypto),
        .init(id: 9, symbol: "MATIC", base: "USD",  type: .crypto),
        .init(id: 10, symbol: "AVAX", base: "USD",  type: .crypto),
        .init(id: 11, symbol: "GBP", base: "USD",  type: .forex),
        .init(id: 12, symbol: "EUR", base: "USD",  type: .forex),
//        .init(id: 13, symbol: "USD", base: "USD",  type: .forex),
        .init(id: 14, symbol: "AUD", base: "USD",  type: .forex),
        .init(id: 15, symbol: "USD", base: "CAD",  type: .forex),
        .init(id: 24, symbol: "XAG", base: "USD",  type: .metal),
        .init(id: 25, symbol: "XAU", base: "USD",  type: .metal),
        .init(id: 30, symbol: "USDT", base: "USD",  type: .crypto),
        .init(id: 31, symbol: "ATOM", base: "USD",  type: .crypto),
        .init(id: 32, symbol: "DOT", base: "USD",  type: .crypto),
        .init(id: 33, symbol: "BNB", base: "USD",  type: .crypto),
        .init(id: 34, symbol: "PEPE", base: "USD",  type: .crypto),
        .init(id: 35, symbol: "XRP", base: "USD",  type: .crypto),
        .init(id: 36, symbol: "CRV", base: "USD",  type: .crypto),
        .init(id: 37, symbol: "MKR", base: "USD",  type: .crypto),
        .init(id: 38, symbol: "OP", base: "USD",  type: .crypto),
        .init(id: 39, symbol: "LINK", base: "USD",  type: .crypto),
        .init(id: 40, symbol: "INJ", base: "USD",  type: .crypto),
        .init(id: 41, symbol: "PYTH", base: "USD",  type: .crypto),
        .init(id: 42, symbol: "BONK", base: "USD",  type: .crypto),
        .init(id: 43, symbol: "TIA", base: "USD",  type: .crypto)
    ]
}
