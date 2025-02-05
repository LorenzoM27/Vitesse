//
//  CustomButton.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//


import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .customButtonStyle(backgroundColor: .black)
        }
    }
}

#Preview {
    CustomButton(title: "Hello", action: {})
}
