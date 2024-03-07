//
//  AssetManager.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-03.
//

import Foundation
import Combine


class AssetManager: ObservableObject, Service {
    
    let name = "AssetManager"
    
    @Published var assetPrices = [Int:AssetPriceData]()
    
    let assets:[Int:AssetPair]
    
    init() {
        var _assets = [Int:AssetPair]()
        let assetPairs = AssetPair.all
        for assetPair in assetPairs {
            _assets[assetPair.id] = assetPair
        }
        self.assets = _assets
    }
    
    func startObserving() {
        self.log("startObserving")
        RNSocketManager.shared.connect()
        
        let assetPairs = AssetPair.all
        for assetPair in assetPairs {
            RNSocketManager.shared.on(.priceChange(assetPair)) { data, ack in
                
                guard 
                    let first = data.first as? [String:Any],
                    let price = first["price"] as? Double
                else {
                    return
                }
                
                self.assets[assetPair.id]?.price = price
                
            }
        }
    }
    
    func stopObserving() {
        self.log("stopObserving")
        
        let assetPairs = AssetPair.all
        for assetPair in assetPairs {
            RNSocketManager.shared.off(.priceChange(assetPair))
        }
    }
    
    
    
}
