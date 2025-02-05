//
//  RegistrationView.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var registrationViewModel: RegistrationViewModel

    var body: some View {
            VStack {
                Text("Inscription")
                    .font(.title)
                
                VStack(spacing: 0) {
                    CustomInputField(title: "Prénom", placeholder: "Entrez votre prénom", text: $registrationViewModel.firstName)
                    
                    CustomInputField(title: "Nom", placeholder:"Entrez votre nom" , text: $registrationViewModel.lastName)
                    
                    CustomInputField(title: "Email", placeholder: "email@exemple.com", text: $registrationViewModel.email)
                    
                    CustomInputField(title: "Mot de passe", isSecureField: true, placeholder: "Entrez votre mot de passe", text: $registrationViewModel.password)
                    
                    CustomInputField(title: "Confirmation mot de passe", isSecureField: true, placeholder: "Confirmez votre mot de passe", text: $registrationViewModel.passwordConfirmation)
                }
            
                VStack {
                    CustomButton(title: "Inscription") {
                        Task {
                            await registrationViewModel.register()
                        }
                    }
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Text("Déja inscrit ?")
                            Text("Connexion")
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.black)
                        .font(.footnote)
                    }

                }
                .padding(.horizontal, 64)
                .padding(.top)
                
                if !registrationViewModel.errorMessage.isEmpty {
                    Text(registrationViewModel.errorMessage)
                        .font(.callout)
                        .foregroundStyle(.red)
                }
                
                if !registrationViewModel.successMessage.isEmpty {
                    Text(registrationViewModel.successMessage)
                        .font(.callout)
                }
            
            }
            .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    RegistrationView(registrationViewModel: RegistrationViewModel(apiService: APIService()))
}
