//
//  LoginView.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Connexion")
                    .font(.title)
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    OnboardingInputField(title: "Email/Pseudo", placeholder: "exemple@email.com", text: $loginViewModel.emailOrUsername)
                    
                    OnboardingInputField(title: "Mot de passe", isSecureField: true, placeholder: "Entrez votre mot de passe", text: $loginViewModel.password)
                    
                    Text("Mot de pass oublié ?")
                        .font(.footnote)
                        .padding(.horizontal)
                }
                
                VStack(spacing: 26) {
                    
                    OnboardingButton(title: "Connexion") {
                        await loginViewModel.login()
                        if loginViewModel.isLoginSuccessful {
                            withAnimation(.smooth) {
                                authViewModel.loginSuccessful()
                            }
                        }
                    }
                    
                    NavigationLink(destination: RegistrationView()) {
                        Text("S'inscrire")
                    }
                    .customButtonStyle()
                    
                }
                .padding(.horizontal, 64)
                .padding(.top, 32)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView(authViewModel: AuthViewModel())
}

