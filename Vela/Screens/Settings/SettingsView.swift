//
//  SettingsView.swift
//  Vela
//
//  Created by Robert Canton on 2024-01-31.
//

import Foundation
import SwiftUI


struct SettingsView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.theme) var theme
    @Environment(\.openURL) var openURL
    
    func resetAllContentAndSettings() {
        do {
            try modelContext.delete(model: Wallet.self)
        } catch {
            print("Failed to reset all content & settings")
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                theme.background
                    .ignoresSafeArea(.all)
                
                Form {
                    
//                    Section {
//                        DisclosureRow("Notifications") { }
//                    }
                    
                    Section {
                        DisclosureRow("About") { }
                        
                        DisclosureRow("Privacy Policy") {
                            openURL(URL(string: "https://app.termly.io/document/privacy-policy/f2b08df2-2a30-4679-9a92-0c888845bbe7")!)
                        }
                    }
                    
                    Section {
                        Button(action: {
                            resetAllContentAndSettings()
                        }) {
                            Text("Reset All Content & Settings")
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                    }
                }
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    Text("Developed by 0xRook")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(32)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CloseButton {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct DisclosureRow: View {
    
    @Environment(\.theme) var theme
    
    let title:String
    let action:()->()
    
    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        
        Button(action: action) {
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(theme.secondary)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
