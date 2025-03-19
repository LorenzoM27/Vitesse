//
//  CustomButtonStyle.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//


import SwiftUI

private struct OnboardingButtonStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(Color("TextColor"))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("AppColor"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func customButtonStyle() -> some View {
        self.modifier(OnboardingButtonStyle())
    }
}
