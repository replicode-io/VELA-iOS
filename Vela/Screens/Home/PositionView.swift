//
//  PositionView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-04.
//

import Foundation
import SwiftUI

struct PositionStat {
    let name:String
    let value:String
    let color:Color
}

struct PositionView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.theme) var theme
    
    @EnvironmentObject var assetManager:AssetManager
    @ObservedObject var assetPair:AssetPair
    
    let wallet:Wallet
    let position:OpenPosition
    
    @State var realizedPnL:BDouble = 0
    
    init(
        wallet:Wallet,
        position: OpenPosition,
        assetPair: AssetPair
    ) {
        self.wallet = wallet
        self.position = position
        self.assetPair = assetPair
    }
    
    var actions:[TradeAction] {
        return wallet.tradeActivites.filter {
            return $0.posId == position.posId
        }
    }
    
    var getRealizedPnL:BDouble {
        var realizedPnL:BDouble = 0
        for action in actions {
            if let tradePNL = action._profitLoss {
                realizedPnL += tradePNL
            }
        }
        return realizedPnL
    }
    
    var stats:[PositionStat] {
        guard let markPrice = assetPair.price else { return [] }
        var stats = [PositionStat]()
        
        let collateral = Double(position.collateral) ?? 0
        
        let uPnL = position.uPnL(for: markPrice)
        let color = uPnL == 0 ? theme.secondary : (uPnL > 0 ? theme.positive : theme.negative)
        let uPnLROI = (uPnL / collateral) * Double(100)
        
        let uPnLFormatted = String(format: "$%.2f (%.2f%%)", uPnL, uPnLROI)
        
        stats.append(
            .init(name: "Unrealized PnL", value: uPnLFormatted, color: color)
        )
        
        let accruedBorrowFee = Double(position.accruedBorrowFee) ?? 0
        let accruedFundingFee = Double(position.accruedFundingFee) ?? 0
        let accruedPositionFee = Double(position.accruedPositionFee) ?? 0
        
        let accruedFees = accruedBorrowFee + accruedFundingFee + accruedPositionFee
        
        stats.append(
            .init(name: "Realized PnL", value: realizedPnL.decimalExpansion(precisionAfterDecimalPoint: 2, rounded: false), color: theme.color(for: realizedPnL))
        )
        
        let estClosingPNL = uPnL - (accruedFees) + (Double(realizedPnL.decimalExpansion(precisionAfterDecimalPoint: 4, rounded: false)) ?? 0)
        let estClosingPNLColor = estClosingPNL == 0 ? theme.secondary : (estClosingPNL > 0 ? theme.positive : theme.negative)
        let estClosingROI = (estClosingPNL / collateral) * Double(100)
        
        stats.append(
            .init(name: "Est. Closing PNL", value: String(format: "%.2f", estClosingPNL), color: estClosingPNLColor)
        )
        
        stats.append(
            .init(name: "Est. Closing ROI", value: String(format: "%.2f%%", estClosingROI), color: estClosingPNLColor)
        )
        
        let netValue = position.netValue(for: uPnL)
        stats.append(
            .init(name: "Net Value", value: String(format: "$%.2f", netValue), color: theme.primary)
        )
        
        return stats
    }
    
    var static1Stats:[PositionStat] {
        
        var stats = [PositionStat]()
        
        let paidPositionFee = Double(position.paidPositionFee) ?? 0
        let size = (Double(position.size) ?? 0) - paidPositionFee
        
        stats.append(
            .init(name: "Pos. Size", value: String(format: "$%.2f", size), color: theme.primary)
        )
        
        let averagePrice = Double(position.averagePrice) ?? 0
        let positionQuantity = size / averagePrice
        
        stats.append(
            .init(name: "Pos. Qty", value: String(format: "%.3f \(assetPair.symbol)", positionQuantity), color: theme.primary)
        )
        
        let leverage = position.leverage
        stats.append(
            .init(name: "Leverage", value: String(format: "%.2fx", leverage), color: theme.primary)
        )
        
        if let liquidationPrice = position.liquidationPrice {
            stats.append(
                .init(name: "Liq. Price", value: String(format: "$%.2f", liquidationPrice), color: theme.primary)
            )
        }
        
        return stats
    }
    
    var markPriceStat:PositionStat {
        if let markPrice = assetPair.price {
            return .init(name: "Mark Price", value: String(format: "$%.2f", markPrice), color: theme.primary)
        } else {
            return .init(name: "Mark Price", value: "-", color: theme.primary)
        }
    }
    
    var static2Stats:[PositionStat] {
        

        var stats = [PositionStat]()
        
        let paidPositionFee = Double(position.paidPositionFee) ?? 0
        let size = (Double(position.size) ?? 0) - paidPositionFee
        
        stats.append(
            .init(name: "Pos. Size", value: String(format: "$%.2f", size), color: theme.primary)
        )
        
        let averagePrice = Double(position.averagePrice) ?? 0
        
        stats.append(
            .init(name: "Avg. Entry Price", value: String(format: "$%.2f", averagePrice), color: theme.primary)
        )
        
        var collateralStr = "-"
        if let collateral = position._collateral {
            collateralStr = "$\(collateral.decimalExpansion(precisionAfterDecimalPoint: 2, rounded: false))"
        }
        stats.append(
            .init(name: "Collateral", value: collateralStr, color: theme.primary)
        )
        
        var pendingCollateralStr = "-"
        if let pendingCollateral = position._pendingCollateral {
            pendingCollateralStr = "$\(pendingCollateral.decimalExpansion(precisionAfterDecimalPoint: 2, rounded: false))"
        }
        stats.append(
            .init(name: "Pending Collateral", value: pendingCollateralStr, color: theme.primary)
        )
        
        stats.append(
            .init(name: "Date/Time Opened", value: position.dateStr, color: theme.primary)
        )
        
        if let chain = Chain(rawValue: position.chainId) {
            stats.append(
                .init(name: "Chain", value: chain.displayName, color: theme.primary)
            )
        }
        
        return stats
    }
    
    
    var realizedFees:[PositionStat] {
        let paidPositionFee = Double(position.paidPositionFee) ?? 0
        let paidBorrowFee = Double(position.paidBorrowFee) ?? 0
        let paidFundingFee = Double(position.paidFundingFee) ?? 0
        
        let paid = paidPositionFee + paidBorrowFee + paidFundingFee
        
        return [
            .init(name: "Realized", value: String(format: "$%.4f", paid), color: theme.primary),
            .init(name: "Position", value: String(format: "$%.4f", paidPositionFee), color: theme.primary),
            .init(name: "Borrow", value: String(format: "$%.4f", paidBorrowFee), color: theme.primary),
            .init(name: "Funding", value: String(format: "$%.4f", paidFundingFee), color: theme.primary)
        ]
    }
    
    var accruedFees:[PositionStat] {
        let accruedPositionFee = Double(position.accruedPositionFee) ?? 0
        let accruedBorrowFee = Double(position.accruedBorrowFee) ?? 0
        let accruedFundingFee = Double(position.accruedFundingFee) ?? 0

        let accrued = accruedPositionFee + accruedBorrowFee + accruedFundingFee
        
        return [
            .init(name: "Est. Closing", value: String(format: "$%.4f", accrued), color: theme.primary),
            .init(name: "Position", value: String(format: "$%.4f", accruedPositionFee), color: theme.primary),
            .init(name: "Borrow", value: String(format: "$%.4f", accruedBorrowFee), color: theme.primary),
            .init(name: "Funding", value: String(format: "$%.4f", accruedFundingFee), color: theme.primary)
        ]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        
                        HStack(alignment: .center, spacing: 16) {
                            Text(assetPair.symbol)
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(theme.primary)
                            
                            PositionTagView(position.isLong ? .long : .short)
                            
                        }
                        
                        Divider()
                            .padding(.vertical, 8)
                        
                        let _stats = stats
                        ForEach(0..<stats.count, id: \.self) { i in
                            let stat = _stats[i]
                            HStack(alignment: .center, spacing: 16) {
                                Text(stat.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(theme.secondary)
                                
                                Text(stat.value)
                                    .foregroundStyle(stat.color)
                            }
                            .id("stats:\(i)")
                        }
                        
                        ForEach(0..<static1Stats.count, id: \.self) { i in
                            let stat = static1Stats[i]
                            HStack(alignment: .center, spacing: 16) {
                                Text(stat.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(theme.secondary)
                                
                                Text(stat.value)
                                    .foregroundStyle(stat.color)
                            }
                            .id("static1Stats:\(i)")
                        }
                        
                        let markPriceStat = markPriceStat
                        HStack(alignment: .center, spacing: 16) {
                            Text(markPriceStat.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(theme.secondary)
                            
                            Text(markPriceStat.value)
                                .foregroundStyle(markPriceStat.color)
                        }
                        .id("markPrice")
                        
                        ForEach(0..<static2Stats.count, id: \.self) { i in
                            let stat = static2Stats[i]
                            HStack(alignment: .center, spacing: 16) {
                                Text(stat.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(theme.secondary)
                                
                                Text(stat.value)
                                    .foregroundStyle(stat.color)
                            }
                            .id("static2Stats:\(i)")
                        }
                        
                        Divider()
                        
                        
                        
                        HStack(alignment: .center, spacing: 16) {
                            Text("Fees")
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(theme.primary)
                        }
                        
                        ForEach(0..<realizedFees.count, id: \.self) { i in
                            let stat = realizedFees[i]
                            HStack(alignment: .center, spacing: 16) {
                                Text(stat.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(theme.secondary)
                                
                                Text(stat.value)
                                    .foregroundStyle(stat.color)
                            }
                            .id("realizedFees:\(i)")
                        }
                        
                        Divider()
                        
                        ForEach(0..<accruedFees.count, id: \.self) { i in
                            let stat = accruedFees[i]
                            HStack(alignment: .center, spacing: 16) {
                                Text(stat.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(theme.secondary)
                                
                                Text(stat.value)
                                    .foregroundStyle(stat.color)
                            }
                            .id("accruedFees:\(i)")
                        }
                        
//                        ForEach(0..<actions.count, id: \.self) { i in
//                            let action = actions[i]
//                            
//                            HStack {
//                                Text(action.actionType)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                
//                                VStack {
//                                    Text(action._profitLoss?.decimalDescription ?? "-")
//                                }
//                                
//                            }
//                                .id("action:\(i)")
//                        }
                        
                        
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle("Open Position")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CloseButton {
                        dismiss()
                    }
                }
                
//                ToolbarItem(placement: .topBarTrailing) {
//                    
//                    Button(action: {
//                        dismiss()
//                    }) {
//                        Image("external_link")
//                            .foregroundStyle(theme.secondary)
//                    }
//                    .buttonStyle(.plain)
//                }
                
            }
        }
        .tint(theme.accent)
        .onAppear {
            realizedPnL = getRealizedPnL
        }
        .onChange(of: actions.count) { value in
            realizedPnL = getRealizedPnL
        }
    }
}
