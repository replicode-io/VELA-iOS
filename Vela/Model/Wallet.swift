//
//  Wallet.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-03.
//

import Foundation
import SwiftData
import Combine

@Model
final class Wallet:Identifiable {
    
    @Attribute(.unique) var id:String
    let blockchain: String
    let network: String
    let address: String
    var name: String
    let isTradingEnabled: Bool
    
    @Attribute(.ephemeral) public var balance:BDouble?
    @Attribute(.ephemeral) public var exchangeBalance:BDouble?
    @Attribute(.ephemeral) public var openPositions:[OpenPosition] = []
    @Attribute(.ephemeral) public var triggerOrders:[TriggerOrder] = []
    @Attribute(.ephemeral) public var pendingOrders:[PendingOrder] = []
    @Attribute(.ephemeral) public var closedPositions:[ClosedPositon] = []
    @Attribute(.ephemeral) public var tradeActivites:[TradeAction] = []
    
    @Transient public var requests = Set<AnyCancellable>()
    
    @Attribute(.ephemeral) public var lastFetch:Date?
    
    var displayName:String {
        if name.isEmpty {
            return address.prefixAddress
        }
        return name
    }
    
    init(blockchain: String, network: String, address: String, name: String) {
        self.id = "\(blockchain):\(network):\(address)".lowercased()
        self.blockchain = blockchain.lowercased()
        self.network = network.lowercased()
        self.address = address.lowercased()
        self.name = name
        self.isTradingEnabled = false
    }
    
    func fetch() {
        
        let now = Date()
        let timeSinceLastFetch = Date().timeIntervalSince1970 - (lastFetch?.timeIntervalSince1970 ?? 0)
        guard timeSinceLastFetch > 1 else {
            return
        }
        
        self.lastFetch = now
        
        fetchBalances()
        fetchExchangeTransactions()
    }
    
    func fetchBalances() {
        fetchBalance()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.fetchPortfolios()
        }
    }
    
    func fetchBalance() {
        
        API.RPC.getTokenAccountBalance(
            chainID: "42161",
            address: address,
            contractAddress: "0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8"
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { state in
            switch state {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }, receiveValue: { response in
            self.balance = BDouble(response.result, over: "1000000")
        })
        .store(in: &requests)
        
        
        
    }
    
    func fetchExchangeTransactions() {
        fetchPositions { success in
            self.fetchTradeActivites { success2 in
                self.fetchOrders { success3 in
                    self.fetchClosedPositions { success4 in
                        self.fetchPortfolios()
                    }
                }
            }
        }
    }
    
    private func fetchPositions(completion: @escaping (_ success:Bool)->()) {
        API.Vela.openPositions(chainID: "42161", address: address.lowercased())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { state in
                switch state {
                case .finished:
                    completion(true)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                    break
                }
            }, receiveValue: { response in
                self.openPositions = response.sorted(by: {
                    return $0.createdAt < $1.createdAt
                })
            })
            .store(in: &requests)
    }
    
    private func fetchOrders(completion: @escaping (_ success:Bool)->()) {
        API.Vela.openOrders(chainID: "42161", address: address.lowercased())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { state in
                switch state {
                case .finished:
                    completion(true)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                    break
                }
            }, receiveValue: { response in
                self.triggerOrders = response.triggerOrders.sorted(by: {
                    return $0.createdAt < $1.createdAt
                })
                
                self.pendingOrders = response.pendingOrders.sorted(by: {
                    return $0.createdAt < $1.createdAt
                })
            })
            .store(in: &requests)
    }
    
    private func fetchClosedPositions(completion: @escaping (_ success:Bool)->()) {
        API.Vela.closedPositions(chainID: "42161", address: address.lowercased())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { state in
                switch state {
                case .finished:
                    completion(true)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                    break
                }
            }, receiveValue: { response in
                self.closedPositions = response.sorted(by: {
                    return $0.createdAt > $1.createdAt
                })
            })
            .store(in: &requests)
    }
    
    private func fetchTradeActivites(completion: @escaping (_ success:Bool)->()) {
        API.Vela.tradeActivites(chainID: "42161", address: address.lowercased())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { state in
                switch state {
                case .finished:
                    completion(true)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                    break
                }
            }, receiveValue: { response in
                self.tradeActivites = response.sorted(by: {
                    return $0.createdAt > $1.createdAt
                })
            })
            .store(in: &requests)
    }
    
    private func fetchPortfolios() {
        API.Vela.portfolios(chainID: "42161", address: self.address)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { state in
                switch state {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }, receiveValue: { response in
                var _balance:BDouble?
                if let first = response.first {
                    _balance = first._vusdBalance
                }
                self.exchangeBalance = _balance
            })
            .store(in: &self.requests)
    }
}
