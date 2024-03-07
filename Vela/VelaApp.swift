//
//  VelaApp.swift
//  Vela
//
//  Created by Robert Canton on 2024-01-30.
//

import SwiftUI
import SwiftData

@main
struct VelaApp: App {
    @State private var theme = Theme(
        accent: Color(hex: "1D98FB"),
        secondaryAccent: Color(hex: "12C2E0"),
        primary: .primary,
        secondary: .secondary,
        background: Color(uiColor: .systemBackground),
        border: Color(uiColor: .opaqueSeparator).opacity(0.5),
        fill: Color(uiColor: .systemFill),
        positive: Color(hex: "00EC6C"),
        negative: Color(hex: "EF384F")
    )
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Wallet.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.theme, theme)
                .tint(theme.accent)
                .preferredColorScheme(.dark)
        }
        .modelContainer(sharedModelContainer)
    }
}
