//
//  Modal.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-08.
//

enum Modal:Identifiable {
    case addWallet
    case editWallet(_ wallet:Wallet)
    case position(_ wallet:Wallet, _ position:OpenPosition, _ assetPair:AssetPair)
    case portfolioOptions(_ portfolio:Portfolio)
    case testflight
    case settings
    
    var id:String {
        switch self {
        case .addWallet:
            return "addWallet"
        case .editWallet(let wallet):
            return "editWallet:\(wallet.id)"
        case .position(let wallet, let positon, let assetPair):
            return "position:\(positon.id)"
        case .portfolioOptions(let portfolio):
            return "portfolioOptions:\(portfolio.id)"
        case .testflight:
            return "testflight"
        case .settings:
            return "settings"
        }
    }
}
