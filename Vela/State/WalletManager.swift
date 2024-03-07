//
//  WalletManager.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-12.
//

import Foundation
import Combine
import SocketIO
import SwiftUI
import SwiftData

class WalletManager: ObservableObject {
    
    @Query var wallets:[Wallet]
    
    
    init() {
        
    }
    
}
