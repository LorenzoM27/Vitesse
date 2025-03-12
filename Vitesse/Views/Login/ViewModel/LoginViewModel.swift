//
//  LoginViewModel.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 05/02/2025.
//

import Foundation


@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var emailOrUsername: String = ""
    @Published var password: String = ""
    @Published var isLoginSuccessful = false
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func login() async {
        
        let endpoint = APIEndpoint.auth(email: emailOrUsername, password: password)
        print(emailOrUsername)
        print(password)
        
        do {
            let loginResponse: LoginResponse = try await apiService.request(endpoint: endpoint)
            TokenManager.shared.token = loginResponse.token
            AdminManager.shared.isAdmin = loginResponse.isAdmin

            isLoginSuccessful = true
            
            
            print(loginResponse.token)
            print(loginResponse.isAdmin)
        } catch {
            print("Impossible to login")
        }
    }
}
