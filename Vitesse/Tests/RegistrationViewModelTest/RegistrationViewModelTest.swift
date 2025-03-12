//
//  RegistrationViewModelTest.swift
//  RegistrationViewModelTest
//
//  Created by Lorenzo Menino on 12/03/2025.
//

import XCTest
@testable import Vitesse

@MainActor
final class RegistrationViewModelTests: XCTestCase {
    
    func testRegisterSuccess() async {
        // Given
        let mockApiService = MockAPIService(shouldSucceed: true)
        let viewModel = RegistrationViewModel(apiService: mockApiService)

        viewModel.firstName = "John"
        viewModel.lastName = "Doe"
        viewModel.email = "john.doe@example.com"
        viewModel.password = "password123"
        viewModel.passwordConfirmation = "password123"

        // When
        await viewModel.register()

        // Then
        XCTAssertTrue(viewModel.isRegistrationSuccessful, "Register should succed")
        XCTAssertEqual(viewModel.successMessage, "Inscription réussie", "Success message")
        XCTAssertEqual(viewModel.errorMessage, "", "No error message")
    }
    
    func testRegisterFailure() async {
        // Given
        let mockApiService = MockAPIService(shouldSucceed: false, error: URLError(.badServerResponse))
        let viewModel = RegistrationViewModel(apiService: mockApiService)

        viewModel.firstName = "John"
        viewModel.lastName = "Doe"
        viewModel.email = "john.doe@example.com"
        viewModel.password = "password123"
        viewModel.passwordConfirmation = "password123"

        // When
        await viewModel.register()

        // Then
        XCTAssertFalse(viewModel.isRegistrationSuccessful, "Register should failed")
        XCTAssertEqual(viewModel.errorMessage, "Erreur lors de l'inscription", "error message")
        XCTAssertEqual(viewModel.successMessage, "", "No success message")
    }

    func testRegisterInvalidEmail() async {
        // Given
        let mockApiService = MockAPIService(shouldSucceed: true)
        let viewModel = RegistrationViewModel(apiService: mockApiService)

        viewModel.firstName = "John"
        viewModel.lastName = "Doe"
        viewModel.email = "invalid-email"
        viewModel.password = "password123"
        viewModel.passwordConfirmation = "password123"

        // When
        await viewModel.register()

        // Then
        XCTAssertFalse(viewModel.isRegistrationSuccessful, "Invalid email, no registration")
        XCTAssertEqual(viewModel.errorMessage, "L'email n'est pas valide.", "Error message for email")
    }

    func testRegisterEmptyNames() async {
        // Given
        let mockApiService = MockAPIService(shouldSucceed: true)
        let viewModel = RegistrationViewModel(apiService: mockApiService)

        viewModel.firstName = ""
        viewModel.lastName = ""
        viewModel.email = "john.doe@example.com"
        viewModel.password = "password123"
        viewModel.passwordConfirmation = "password123"

        // When
        await viewModel.register()

        // Then
        XCTAssertFalse(viewModel.isRegistrationSuccessful, "no registration, empty fields")
        XCTAssertEqual(viewModel.errorMessage, "Le prénom et le nom sont requis.", "Error message")
    }

    func testRegisterPasswordMissMatch() async {
        // Given
        let mockApiService = MockAPIService(shouldSucceed: true)
        let viewModel = RegistrationViewModel(apiService: mockApiService)

        viewModel.firstName = "John"
        viewModel.lastName = "Doe"
        viewModel.email = "john.doe@example.com"
        viewModel.password = "password123"
        viewModel.passwordConfirmation = "password456"

        // When
        await viewModel.register()

        // Then
        XCTAssertFalse(viewModel.isRegistrationSuccessful, "Passwords doesn't match, so no registration")
        XCTAssertEqual(viewModel.errorMessage, "Les mots de passe ne correspondent pas.", "Error message")
    }
}
