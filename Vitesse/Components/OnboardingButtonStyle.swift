//
//  CustomButtonStyle.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//


import SwiftUI

private struct OnboardingButtonStyle: ViewModifier {
    var backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func customButtonStyle(backgroundColor: Color) -> some View {
        self.modifier(OnboardingButtonStyle(backgroundColor: backgroundColor))
    }
}
