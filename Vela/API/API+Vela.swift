//
//  API+Vela.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-02.
//

import Foundation
import Combine

extension API {
    
    struct Vela {
        
        static func openPositions(chainID:String, address:String) -> AnyPublisher<[OpenPosition], Error> {
            
            return NetworkManager.shared.request(
                .GET,
                .vela,
                .openPositions(chainID: chainID, address: address),
                ofType: [OpenPosition].self
            )
        }
        
        static func openOrders(chainID:String, address:String) -> AnyPublisher<OpenOrdersDTO, Error> {
            
            return NetworkManager.shared.request(
                .GET,
                .vela,
                .openOrders(chainID: chainID, address: address),
                ofType: OpenOrdersDTO.self
            )
        }
        
        static func closedPositions(chainID:String, address:String) -> AnyPublisher<[ClosedPositon], Error> {
            
            return NetworkManager.shared.request(
                .GET,
                .vela,
                .closedPositions(chainID: chainID, address: address),
                ofType: [ClosedPositon].self
            )
        }
        
        static func tradeActivites(chainID:String, address:String) -> AnyPublisher<[TradeAction], Error> {
            
            return NetworkManager.shared.request(
                .GET,
                .vela,
                .tradeActivities(chainID: chainID, address: address),
                ofType: [TradeAction].self
            )
        }
        
        static func portfolios(chainID:String, address:String) -> AnyPublisher<[PortfolioDTO], Error> {
            
            return NetworkManager.shared.request(
                .GET,
                .vela,
                .portfolios(chainID: chainID, address: address),
                ofType: [PortfolioDTO].self
            )
        }
        
    }
}
