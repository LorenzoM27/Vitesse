//
//  LoginView.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    var body: some View {
        NavigationView {
            VStack {
                Text("Connexion")
                    .font(.title)
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    CustomInputField(title: "Email/Pseudo", placeholder: "exemple@email.com", text: $loginViewModel.emailOrUsername)
                    
                    CustomInputField(title: "Mot de passe", isSecureField: true, placeholder: "Entrez votre mot de passe", text: $loginViewModel.password)
                    
                    Text("Mot de pass oublié ?")
                        .font(.footnote)
                        .padding(.horizontal)
                }
                
                VStack(spacing: 26) {
                    CustomButton(title: "Connexion") {
                        Task {
                            await loginViewModel.login()
                        }
                    }
                    
                    NavigationLink(destination: RegistrationView(registrationViewModel: RegistrationViewModel(apiService: APIService()))) {
                        Text("S'inscrire")
                            .customButtonStyle(backgroundColor: .black)
                    }
                    
                }
                .padding(.horizontal, 64)
                .padding(.top, 32)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView(loginViewModel: LoginViewModel(apiService: APIService()))
}

