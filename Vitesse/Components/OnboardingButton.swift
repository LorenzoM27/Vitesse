//
//  CustomButton.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//


import SwiftUI

struct OnboardingButton: View {
    var title: String
    var action: () async -> Void

    var body: some View {
        Button(action: {
            Task {
                await action()
            }
        }) {
            Text(title)
                
        }
        .customButtonStyle(backgroundColor: .black)
    }
}

#Preview {
    OnboardingButton(title: "Hello", action: {})
}
