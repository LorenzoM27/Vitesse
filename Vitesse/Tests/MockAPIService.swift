//
//  test.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 12/03/2025.
//

import Foundation

import Foundation

class MockAPIService: APIService {
    private let shouldSucceed: Bool
    private let error: Error?
    private let response: Any?
    
    init(shouldSucceed: Bool = true, error: Error? = nil, response: Any? = nil) {
        self.shouldSucceed = shouldSucceed
        self.error = error
        self.response = response
    }
    
    override func requestWithoutReturn(endpoint: APIEndpoint) async throws {
        if !shouldSucceed, let error = error {
            throw error
        }
    }
    
    override func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        if let response = response as? T {
            return response
        }
        
        if !shouldSucceed {
            if let error = error {
                throw error
            } else {
                throw URLError(.badServerResponse)
            }
        }
        
        // Gérer les endpoints spécifiques pour simuler des réponses réalistes
        switch endpoint {
        case .auth(let email, let password):
            return LoginResponse(token: "mockToken123", isAdmin: true) as! T
        case .getCandidates:
            let mockCandidates = [
                CandidateDTO(id: UUID().uuidString, email: "test@example.com", firstName: "Test", lastName: "User", phone: "123456789", note: "", linkedinURL: "")
            ]
            return mockCandidates as! T
        case .createCandidate:
            let mockCandidate = CandidateDTO(id: UUID().uuidString, email: "new@example.com", firstName: "New", lastName: "Candidate", phone: "987654321", note: "", linkedinURL: "")
            return mockCandidate as! T
        case .updateFavoriteStatus:
            let updatedCandidate = CandidateDTO(id: UUID().uuidString, email: "fav@example.com", firstName: "Fav", lastName: "Candidate", phone: "555555555", note: "", linkedinURL: "")
            return updatedCandidate as! T
        default:
            throw URLError(.unsupportedURL)
        }
    }
}
