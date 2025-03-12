//
//  VitesseApp.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 04/02/2025.
//

import SwiftUI

@main
struct VitesseApp: App {
    
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
                   if authViewModel.isAuthenticated {
                       CandidatesListView()
                   } else {
                       LoginView(authViewModel: authViewModel)
                   }
               }
    }
}
