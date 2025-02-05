//
//  RegistrationViewModel.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//

import SwiftUI

@MainActor
final class RegistrationViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    
    @Published var errorMessage: String = ""
    @Published var successMessage: String = ""
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func validateFields() -> Bool {
        
        if firstName.isEmpty || lastName.isEmpty {
            errorMessage = "Le prénom et le nom sont requis."
            return false
        }
        
        if !isValidEmail(email) {
            errorMessage = "L'email n'est pas valide."
            return false
        }
        
        if password != passwordConfirmation {
            errorMessage = "Les mots de passe ne correspondent pas."
            return false
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    

    func register() async {
        guard validateFields() else { return }
        
        let endpoint = APIEndpoint.register(email: email, password: password, firstName: firstName, lastName: lastName)
        
        do {
            try await apiService.requestWithoutReturn(endpoint: endpoint)
            successMessage = "Inscription réussie"
        } catch {
            print("Impossible to register")
        }
        
        print("Utilisateur inscrit avec succès.")
    }
    
}
