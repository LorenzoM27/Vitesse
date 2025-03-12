//
//  AuthViewModel.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 08/02/2025.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    func loginSuccessful() {
        isAuthenticated = true
    }
}
