//
//  CustomButtonStyle.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//


import SwiftUI

private struct customButtonStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func customButtonStyle() -> some View {
        self.modifier(customButtonStyle())
    }
}
