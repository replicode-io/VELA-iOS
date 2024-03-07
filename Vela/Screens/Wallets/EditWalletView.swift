//
//  EditWalletView.swift
//  Vela
//
//  Created by Robert Canton on 2024-01-31.
//


import Foundation
import SwiftUI
import Combine
import SwiftData


struct EditWalletView: View {
    
    @Environment(\.theme) var theme
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    let wallet:Wallet
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
                            Text(address)
                                .foregroundStyle(theme.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        
                        TextField("Name", text: $name)
                    }
                    
                    Section {
                        Button(action: {
                            modelContext.delete(wallet)
                            dismiss()
                        }) {
                            Text("Delete Wallet")
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .contentShape(Rectangle())
                                
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
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
            .navigationTitle("Edit Wallet")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CloseButton {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        wallet.name = name
                        
                        try? modelContext.save()
                        
                        selectedCard = .wallet(wallet)
                        
                        dismiss()
                        
                    }) {
                        Text("Save")
                            .bold()
//                            .foregroundStyle(viewModel.isComplete ? theme.accent : .secondary)
                    }
                    .disabled(address.isEmpty)
                }
            }
            .onAppear {
                address = wallet.address
                name = wallet.name
            }
        }
    }
}

