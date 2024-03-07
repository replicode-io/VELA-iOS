//
//  Portfolio.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-03.
//

import Foundation
import Combine

class Portfolio:ObservableObject, Identifiable, Equatable, Hashable {
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: Portfolio, rhs: Portfolio) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id:String {
        return wallet.id
    }
    
    @Published var wallet:Wallet
    @Published var openPositions = [OpenPosition]()
    @Published var pendingOrders = [PendingOrder]()
    @Published var closedPositions = [ClosedPositon]()
    @Published var isCollapsed = false
    
    var requests = Set<AnyCancellable>()
    
    init(wallet:Wallet) {
        self.wallet = wallet
        self.observe()
        
    }
    
    func observe() {
        
    }
    
    func stopObserving() {
        
    }
    
    func fetch() {
        fetchPositions { success in
            guard success else {
                return
            }
        }
        
        self.fetchOrders { success2 in
            guard success2 else {
                return
            }
        }
        
        self.fetchedClosedPositions { success3 in
            guard success3 else {
                return
            }
        }
        
        self.fetchedClosedPositions { success3 in
            guard success3 else {
                return
            }
        }
    }
    
    private func fetchPositions(completion: @escaping (_ success:Bool)->()) {
        API.Vela.openPositions(chainID: "42161", address: wallet.address.lowercased())
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
        API.Vela.openOrders(chainID: "42161", address: wallet.address.lowercased())
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
                self.pendingOrders = response.pendingOrders.sorted(by: {
                    return $0.createdAt < $1.createdAt
                })
            })
            .store(in: &requests)
    }
    
    private func fetchedClosedPositions(completion: @escaping (_ success:Bool)->()) {
        API.Vela.closedPositions(chainID: "42161", address: wallet.address.lowercased())
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
    
}
