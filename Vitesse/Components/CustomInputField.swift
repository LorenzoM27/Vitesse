//
//  CustomInputField.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//

import SwiftUI

struct CustomInputField: View {
    
    var title: String
    var isSecureField = false
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.callout)
                .padding()
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    CustomInputField(title: "Email/Username", placeholder: "nom@exemple.com", text: .constant(""))
}
