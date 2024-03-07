//
//  ContentViewModel.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-02.
//

import Foundation
import Combine


class ContentViewModel: ObservableObject {
    
    var requests = Set<AnyCancellable>()
    
    @Published var openPositions = [OpenPosition]()
    
    init() {
        
    }
    
    func fetch() {
        API.Vela.openPositions(chainID: "42161", address: "0x5D8b7Cb236BFE00465f06Ae28af487E779C87c42")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { state in
                
            }, receiveValue: { response in
                self.openPositions = response
            })
            .store(in: &requests)
    }
    
    
}


