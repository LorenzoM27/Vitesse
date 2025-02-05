//
//  VitesseApp.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 04/02/2025.
//

import SwiftUI

@main
struct VitesseApp: App {
    
    @StateObject var apiService = APIService()

    
    var body: some Scene {
        WindowGroup {
            LoginView(loginViewModel: LoginViewModel(apiService: apiService))
        }
        .environmentObject(apiService)
    }
}
