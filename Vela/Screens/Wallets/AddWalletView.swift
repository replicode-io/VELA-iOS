//
//  AddWalletView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-03.
//

import Foundation
import SwiftUI
import Combine
import SwiftData

enum WalletField:Int, Identifiable {
    case address = 1
    case name = 2
    
    var id:Int {
        return rawValue
    }
}

struct AddWalletView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Binding var selectedCard:CardOption?
    
    @FocusState var focus:WalletField?
    @State var address = ""
    @State var name = ""
    
    var body: some View {
        NavigationStack {
            ZStack {

                Form {

                    Section(header: Text("Hex Address or ENS")) {
                        HStack {
                            TextField("Ethereum Address", text: $address)
                                .textInputAutocapitalization(.never)
                                .truncationMode(.middle)
                                .focused($focus, equals: WalletField.address)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onAppear {
                                    focus = .address
                                }
                        }
                        
                        TextField("Name", text: $name)
                    }
                    
                }
                
                VStack(alignment: .trailing) {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        PasteButton(payloadType: String.self) { strings in
                            switch focus {
                            case .address:
                                address = strings.first ?? ""
                                break
                            case .name:
                                name = strings.first ?? ""
                                break
                            case nil:
                                break
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Add Wallet")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
//            .toolbarBackground(theme.secondaryBackground, for: .navigationBar, .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CloseButton {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {

                        let wallet = Wallet(
                            blockchain: "eth",
                            network: "mainnet",
                            address: address,
                            name: name
                        )
                        modelContext.insert(wallet)
                        try? modelContext.save()
                        
                        withAnimation(
                            Animation
                                .easeOut(duration: 1)
                                .delay(1)
                        ) {
                            selectedCard = .wallet(wallet)
                        }
                        
                        dismiss()
                        
                    }) {
                        Text("Save")
                            .bold()
//                            .foregroundStyle(viewModel.isComplete ? theme.accent : .secondary)
                    }
                    .disabled(address.isEmpty)
                }
            }
        }
    }
}

