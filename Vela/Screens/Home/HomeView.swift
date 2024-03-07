//
//  HomeView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-02.
//

import Foundation
import SwiftUI
import IrregularGradient
import UniformTypeIdentifiers
import SwiftData

enum CardOption:Identifiable, Hashable {
    case wallet(_ wallet:Wallet)
    case addWallet
    
    var id:String {
        switch self {
        case .wallet(let wallet):
            return "wallet:\(wallet.id)"
        case .addWallet:
            return "addWallet"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct HomeView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.theme) var theme
    
    @EnvironmentObject var viewModel:ContentViewModel
    @EnvironmentObject var assetManager:AssetManager
    
    var gradientColors:[Color] {
        return [Color(hex: "2849A4"), Color(hex: "CEED"), Color(hex: "A027D")]
    }
    
    @State var modal:Modal?
    @State var isCollapsed = false
    
    @State var draggedItem : Portfolio?
    
    @State var path = [Route]()
    
    @State var selectedCard: CardOption? = .addWallet
    
    @Query var wallets:[Wallet]
    
    @State var animateBackground:Bool = false
    
    @State var isPositionsCollapsed = false
    @State var isOrdersCollapsed = false
    @State var isClosedPositionsCollapsed = true
    @State var isTradeActivityCollapsed = true
    
    var selectedWallet:Wallet? {
        switch selectedCard {
        case .wallet(let wallet):
            return wallet
        default:
            return nil
        }
    }
       
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                
                
                
                ZStack {
                    Color.black
                    
                    VStack {
                        
                        ZStack {
                            Rectangle()
                                .fill(.clear)
                                .overlay (
                                    Image("g10")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .scaleEffect(y: -1)
                                        .opacity(0.75)
                                )
                                .frame(height: 300)
                            
//                            Rectangle()
//                                .fill(.clear)
//                                .overlay (
//                                    Image("grain")
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(maxWidth: .infinity)
//                                        .scaleEffect(x: -1, y: -1)
//                                        .blendMode(.screen)
//                                        .opacity(0.5)
//                                )
                        }
                        
                        Spacer()
                    }
                    
//                    Rectangle()
//                        .fill(.clear)
//                        .overlay(
//                    Image("grain")
//                        .resizable()
//                        .scaledToFill()
//                        .blendMode(.screen)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .ignoresSafeArea(.all)
//                    )
                    
//                    Rectangle()
//                        .background(Color.clear)
//                        .irregularGradient(colors: gradientColors,
//                                           background: gradientColors.first!,
//                                           animate: animateBackground,
//                                           speed: 0.15)
//                        .onAppear {
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                                animateBackground = true
//                            }
//                        }

                    LinearGradient(gradient: Gradient(colors: [
                        .clear,
                        Color.black,
                        Color.black,
                    ]), startPoint: .top, endPoint: .bottom)
                }
                .edgesIgnoringSafeArea(.all)
                
                GeometryReader { reader in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            
                            
                            ScrollView(.horizontal) {
                                LazyHStack(spacing: 16) {
                                    
                                    ForEach(wallets) { wallet in
                                        CardView(
                                            wallet: wallet,
                                            selectedCard: $selectedCard
                                        ) {
                                            withAnimation {
                                                if selectedCard == .wallet(wallet) {
                                                    modal = .editWallet(wallet)
                                                } else {
                                                    selectedCard = .wallet(wallet)
                                                }
                                            }
                                        }
                                            .id(CardOption.wallet(wallet))
                                            .frame(
                                                width: reader.size.width - 32 - 32 - 32,
                                                height: 180
                                            )
                                            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                                content
                                                    .opacity(phase.isIdentity ? 1.0 : 0.5)
                                            }
                                    }
                                    
                                    AddWalletCardView() {
                                        if selectedCard == .addWallet {
                                            modal = .addWallet
                                        } else {
                                            withAnimation {
                                                selectedCard = .addWallet
                                            }
                                        }
                                    }
                                    .id(CardOption.addWallet)
                                    .frame(
                                        width: max(reader.size.width - 32 - 32 - 32, 0),
                                        height: 180
                                    )
                                    .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1.0 : 0.5)
                                    }
    
                                }
                                .scrollTargetLayout()
                            }
                            .contentMargins(.horizontal, 16, for: .scrollContent)
                            .scrollTargetBehavior(.viewAligned)
                            .scrollIndicators(.hidden)
                            .scrollPosition(id: $selectedCard)
                            .padding(.vertical)
                            
//                            let scopes = ["Positions", "Orders", "Activity"]
////                            ScrollView(.horizontal) {
//                                HStack(alignment: .center, spacing: 0) {
//                                    ForEach(0..<scopes.count, id: \.self) { i in
//                                        let scope = scopes[i]
//                                        RoundedButton(
//                                            title: scope.uppercased(),
//                                            count: i < 2 ? 2 : 0,
//                                            isSelected: i == 0) {
//                                            withAnimation(
//                                                Animation.easeOut(duration: 0.1)
//                                            ) {
//                                                //                                            self.selectedIndex = i
//                                            }
//                                        }
//                                        
//                                        
//                                    }
//                                }
//                                .padding()
////                            }
//                            
                            
                            if let wallet = selectedWallet {
                                let positions = wallet.openPositions
                                if !positions.isEmpty {
                                    HeaderView(
                                        title: "Open Positions",
                                        count: positions.count,
                                        toggle: $isPositionsCollapsed
                                    )
                                    
                                    if !isPositionsCollapsed {
                                        LazyVStack(alignment: .leading, spacing: 0) {
                                            ForEach(positions) { position in
                                                if let assetPair = assetManager.assets[position.tokenId] {
                                                    Button(action: {
                                                        modal = .position(wallet, position, assetPair)
                                                    }) {
                                                        PositionRow(position: position, assetPair: assetPair)
                                                    }
                                                    .buttonStyle(.plain)
                                                }
                                            }
                                        }
                                        .transition(.opacity)
                                    }
                                }
                                

                                
                                let triggerOrders = wallet.triggerOrders
                                let pendingOrders = wallet.pendingOrders
                                if !triggerOrders.isEmpty || !pendingOrders.isEmpty {
                                    
//                                    Divider()
//                                        .padding(.horizontal)
//                                        .padding(.top, 8)
                                    
                                    HeaderView(
                                        title: "Open Orders",
                                        count: triggerOrders.count + pendingOrders.count,
                                        toggle: $isOrdersCollapsed
                                    )
                                    
                                    if !isOrdersCollapsed {
                                        LazyVStack(alignment: .leading, spacing: 0) {
                                            ForEach(0..<triggerOrders.count, id: \.self) { index in
                                                let order = triggerOrders[index]
                                                
                                                if let assetPair = assetManager.assets[order.tokenId] {
                                                    TriggerOrderRow(order: order, assetPair: assetPair)
                                                }
                                            }
                                            
                                            ForEach(0..<pendingOrders.count, id: \.self) { index in
                                                let order = pendingOrders[index]
                                                
                                                if let assetPair = assetManager.assets[order.tokenId] {
                                                    PendingOrderRow(order: order, assetPair: assetPair)
                                                }
                                            }
                                        }
                                        .transition(.opacity)
                                    }
                                }
                                
                                let closedPositions = wallet.closedPositions
                                if !closedPositions.isEmpty {
                                    
//                                    Divider()
//                                        .padding(.horizontal)
//                                        .padding(.top, 8)
                                    
                                    HeaderView(
                                        title: "Closed Positions",
                                        count: 0,
                                        toggle: $isClosedPositionsCollapsed
                                    )
                                    
                                    if !isClosedPositionsCollapsed {
                                        LazyVStack(alignment: .leading, spacing: 0) {
                                            ForEach(closedPositions) { position in
                                                
                                                if
                                                    let tokenId = position._tokenId,
                                                    let assetPair = assetManager.assets[tokenId]
                                                {
                                                    Button(action: {
                                                        
                                                    }) {
                                                        ClosedPositionRow(position: position, assetPair: assetPair)
                                                    }
                                                    .buttonStyle(.plain)
                                                }
                                            }
                                        }
                                        .transition(.opacity)
                                    }
                                }
                                
                            }
                            
                            
//                            if let portfolio = selectedPortfolio {
//                                LazyVStack(alignment: .leading, spacing: 0) {
//                                    ForEach(portfolio.pendingOrders) { order in
//                                        if let assetPair = assetManager.assets[order.tokenId] {
//                                            OrderRow(order: order, assetPair: assetPair)
//                                        }
//                                    }
//                                }
//                            }
                            
//                            Divider()
//                                .padding(.horizontal)
//                                .padding(.top, 8)
//                            
//                            HeaderView(title: "Trade History")
//                            
//                            if let portfolio = selectedPortfolio {
//                                LazyVStack(alignment: .leading, spacing: 0) {
//                                    ForEach(portfolio.closedPositions) { position in
//                                        if let assetPair = assetManager.assets[Int(position.tokenId) ?? 0] {
//                                            ClosedPositionRow(position: position, assetPair: assetPair)
//                                        }
//                                    }
//                                }
//                            }
                            
                            Spacer()
                        }
                        //                    .padding()
                    }
                    .refreshable {
                        for wallet in wallets {
                            wallet.fetch()
                        }
                    }
                }
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationDestination(for: Route.self) { route in
//                switch route {
//                case .portfolio(let portfolio):
//                    PortfolioDetailView(portfolio: portfolio)
//                default:
//                    EmptyView()
//                }
//            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    NavButton(iconName: "gearshape.fill", color: theme.secondary) {
                        modal = .settings
                    }
                }
                
                if !wallets.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavButton(iconName: "plus", color: theme.secondary) {
                            modal = .addWallet
                        }
                    }
                }
            }
        }
        .sheet(item: $modal) { item in
            switch item {
            case .addWallet:
                AddWalletView(selectedCard: $selectedCard)
            case .editWallet(let wallet):
                EditWalletView(wallet: wallet, selectedCard: $selectedCard)
            case .position(let wallet, let position, let assetPair):
                PositionView(
                    wallet: wallet,
                    position: position,
                    assetPair: assetPair
                )
                .presentationDetents([.fraction(0.8), .large])
            case .testflight:
                TestflightView()
            case .settings:
                SettingsView()
            default:
                EmptyView()
            }
        }
        .onAppear {
            if let first = wallets.first {
                selectedCard = .wallet(first)
                first.fetch()
            }
            
            onWalletsChanged()
            
            RNSocketManager.shared.off(.walletTransaction)
            RNSocketManager.shared.off(.exchangeTransaction)
            
            RNSocketManager.shared.on(.walletTransaction) { data, ack in
                guard
                    let first = data.first as? [String:Any],
                    let address = first["address"] as? String
                        
                else {
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for wallet in wallets {
                        if wallet.address.lowercased() == address.lowercased() {
                            wallet.fetchBalances()
                        }
                    }
                }
            }
            
            RNSocketManager.shared.on(.exchangeTransaction) { data, ack in
                guard
                    let first = data.first as? [String:Any],
                    let address = first["address"] as? String
                        
                else {
                    return
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for wallet in wallets {
                        if wallet.address.lowercased() == address.lowercased() {
                            wallet.fetchExchangeTransactions()
                        }
                    }
                }
            }
        }
        .onChange(of: wallets.count) { value, x in
            onWalletsChanged()
        }
        .onChange(of: selectedWallet) { value, x in
            if selectedWallet?.lastFetch == nil {
                selectedWallet?.fetch()
            }
        }
        
        
        
    }
    
    func onWalletsChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            for wallet in wallets {
                RNSocketManager.shared.emit(.joinRoom(wallet.id))
            }
        }
    }
}

struct MyDropDelegate : DropDelegate {

    let item : Portfolio
    @Binding var items : [Portfolio]
    @Binding var draggedItem : Portfolio?

    func performDrop(info: DropInfo) -> Bool {
        return true
    }

    func dropEntered(info: DropInfo) {
        guard let draggedItem = self.draggedItem else {
            return
        }

        if draggedItem != item {
            let from = items.firstIndex(of: draggedItem)!
            let to = items.firstIndex(of: item)!
            withAnimation(.default) {
                self.items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
            }
        }
    }
}
