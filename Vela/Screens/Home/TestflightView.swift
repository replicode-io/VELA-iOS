//
//  TestflightView.swift
//  Parallax
//
//  Created by Robert Canton on 2024-01-20.
//

import Foundation
import SwiftUI

struct TestflightView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.theme) var theme
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .center, spacing: 16) {
                    
                    Spacer(minLength: 0)
                    
                    Text("ALPHA v1.0.0 (2)")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.bottom)
                    
                    Text("Thank you for testing!")
                        
                    
                    Text("Please share your feedback, feature requests, & suggestions through Testflight.")
                        .font(.system(size: 13))
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                                        
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        // Special scheme specific to TestFlight
                        let presenceCheck = URL(string: "itms-beta://")!
                        // Special link that includes the app's ID
                        let deepLink = URL(string: "https://beta.itunes.apple.com/v1/app/6476932997")!
                        let app = UIApplication.shared
                        if app.canOpenURL(presenceCheck) {
                            app.open(deepLink)
                        }
                    }) {
                        Text("Open in Testflight")
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .frame(height: 48)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(theme.accent)
                            )
                    }
                }
                .padding()
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CloseButton {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
    
}
