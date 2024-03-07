//
//  API.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-02.
//

import Foundation

struct API {
    
    enum Hosts:String {
        case vela = "https://api.vela.exchange/graph"
        case rpc = "https://vex.replicode.tools"
    }
    
    enum Endpoints {
        case openPositions(chainID:String, address:String)
        case openOrders(chainID:String, address:String)
        case closedPositions(chainID:String, address:String)
        case tradeActivities(chainID:String, address:String)
        case portfolios(chainID:String, address:String)
        
        case tokenAccountBalance(chainID:String, address:String, contractAddress:String)
        
        var str:String {
            switch self {
            case .openPositions(let chainID, let address):
                return "/open_positions/\(chainID)/\(address)"
            case .openOrders(let chainID, let address):
                return "/open_orders/\(chainID)/\(address)"
            case .closedPositions(let chainID, let address):
                return "/closed_positions/\(chainID)/\(address)"
            case .tradeActivities(let chainID, let address):
                return "/trade_activities/\(chainID)/\(address)"
            case .portfolios(let chainID, let address):
                return "/portfolios/\(chainID)/\(address)"
            case .tokenAccountBalance(let chainID, let address, let contractAddress):
                return "?module=account&action=tokenbalance&contractaddress=\(contractAddress)&address=\(address)&tag=latest"
            }
        }
    }
    
}
