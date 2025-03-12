//
//  AddCandidatView.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 17/02/2025.
//

import SwiftUI

struct AddCandidatView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var candidatesListViewModel = CandidatesViewModel()
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 0) {
                
                OnboardingInputField(title: "Email", placeholder: "Entrez votre email", text: $candidatesListViewModel.email)
                
                OnboardingInputField(title: "Prénom", placeholder: "Entrez votre prénom", text: $candidatesListViewModel.firstName)
                
                OnboardingInputField(title: "Nom", placeholder: "Entrez votre nom", text: $candidatesListViewModel.lastName)
                
                OnboardingInputField(title: "Téléphone", placeholder: "0102030405", text: $candidatesListViewModel.phone)
                
                OnboardingInputField(title: "LinkedIn", placeholder: "John Doe", text: $candidatesListViewModel.linkedinURL)
                
                OnboardingInputField(title: "Note", placeholder: "Ajouter une note", text: $candidatesListViewModel.note)
            }
            
            OnboardingButton(title: "Ajouter un candidat") {
                await candidatesListViewModel.addCandidat()
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}

#Preview {
    AddCandidatView()
}
