//
//  LoginViewModelTests.swift
//  VitesseTests
//
//  Created by Lorenzo Menino on 05/03/2025.
//

import XCTest
@testable import Vitesse

@MainActor
final class LoginViewModelTests: XCTestCase {
    
    func testLoginSuccess() async {
        // Given
        let mockApiService = MockAPIService(shouldSucceed: true, response: LoginResponse(token: "mockToken123", isAdmin: false))
        let viewModel = LoginViewModel(apiService: mockApiService)
        
        viewModel.emailOrUsername = "test@example.com"
        viewModel.password = "password123"
        
        // When
        await viewModel.login()
        
        // Then
        XCTAssertTrue(viewModel.isLoginSuccessful, "user has to be logged in.")
        XCTAssertEqual(TokenManager.shared.token, "mockToken123", "Token has to be stored.")
        XCTAssertFalse(AdminManager.shared.isAdmin, "user is not admin.")
    }
    
    func testLoginFailure() async {
           // Given
           let mockApiService = MockAPIService(shouldSucceed: false, error: URLError(.userAuthenticationRequired))
           let viewModel = LoginViewModel(apiService: mockApiService)
           
           viewModel.emailOrUsername = "wrong@example.com"
           viewModel.password = "wrongpassword"
           
           // When
           await viewModel.login()
           
           // Then
           XCTAssertFalse(viewModel.isLoginSuccessful, "Can't login.")
           XCTAssertNil(TokenManager.shared.token, "No Token.")
       }
}
