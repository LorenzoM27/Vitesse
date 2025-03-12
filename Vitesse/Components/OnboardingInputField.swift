//
//  CustomInputField.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//

import SwiftUI

struct OnboardingInputField: View {
    
    var title: String
    var isSecureField = false
    var placeholder: String
    var isNote = false
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
                if isNote {
                    TextEditor(text: $text)
                        .frame(height: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(10)
                } else {
                    
                    TextField(placeholder, text: $text)
                        .textInputAutocapitalization(.never)
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
}

#Preview {
    OnboardingInputField(title: "Email/Username", placeholder: "nom@exemple.com", text: .constant(""))
}
