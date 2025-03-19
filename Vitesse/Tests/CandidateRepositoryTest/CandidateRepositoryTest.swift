//
//  CandidateRepositoryTest.swift
//  CandidateRepositoryTest
//
//  Created by Lorenzo Menino on 12/03/2025.
//


import XCTest
@testable import Vitesse

@MainActor
final class CandidatesRepositoryTests: XCTestCase {
    
    // MARK: - Test fetchCandidatesList
    
    func testFetchCandidatesListSuccess() async {
        // Given
        let mockCandidates = [
            CandidateDTO(id: UUID(), firstName: "John", lastName: "Doe", email: "test@example.com", phone: "123456789", note: "", linkedinURL: "", isFavorite: false)
        ]
        let mockApiService = MockAPIService(shouldSucceed: true, response: mockCandidates)
        let viewModel = CandidatesRepository(apiService: mockApiService)
        
        // When
        await viewModel.fetchCandidatesList()
        
        // Then
        XCTAssertEqual(viewModel.candidates.count, 1, "Have to be 1 candidate")
        XCTAssertEqual(viewModel.candidates.first?.email, "test@example.com", "Have to be same email")
    }
    
    func testFetchCandidatesListFailure() async {
        // Given
        let mockApiService = MockAPIService(shouldSucceed: false, error: URLError(.badServerResponse))
        let viewModel = CandidatesRepository(apiService: mockApiService)
        
        // When
        await viewModel.fetchCandidatesList()
        
        // Then
        XCTAssertTrue(viewModel.candidates.isEmpty, "List have to be empty")
    }
    
    // MARK: - Test addCandidate
 
    func testAddCandidateSuccess() async {
        // Given
        let mockCandidateDTO = CandidateDTO(id: UUID(), firstName: "John", lastName: "Doe", email: "new@example.com", phone: "987654321", note: "Test note", linkedinURL: "linkedin.com/in/johnedoe", isFavorite: false)
        
        let mockApiService = MockAPIService(shouldSucceed: true, response: mockCandidateDTO)
        let viewModel = CandidatesRepository(apiService: mockApiService)
    
        
        // When
        await viewModel.addCandidate(email: "new@example.com", note: "Test note", linkedinURL: "linkedin.com/in/johndoe", firstName: "John", lastName: "Doe", phone: "987654321")
        
        // Then
        XCTAssertEqual(viewModel.candidates.count, 1, "Have to be added one candidate")
        XCTAssertEqual(viewModel.candidates.first?.email, "new@example.com", "Same email")
    }

    func testAddCandidateFailure() async {
        // Given
        let mockApiService = MockAPIService(shouldSucceed: false, error: URLError(.badServerResponse))
        let viewModel = CandidatesRepository(apiService: mockApiService)
        
        
        // When
        await viewModel.addCandidate(email: "new@example.com", note: "Test note", linkedinURL: "linkedin.com/in/johndoe", firstName: "John", lastName: "Doe", phone: "987654321")
        
        // Then
        XCTAssertTrue(viewModel.candidates.isEmpty, "None candidate have to be added")
    }
    
    
    
    // MARK: - Test deleteCandidate

    func testDeleteCandidateSuccess() async {
        // Given
        let candidateDTO = CandidateDTO(id: UUID(), firstName: "John", lastName: "Doe", email: "test@example.com", phone: "123456789", note: "Test", linkedinURL: "linkedin.com/in/johndoe", isFavorite: false)
        let candidate = Candidate(from: candidateDTO)

        let mockApiService = MockAPIService(shouldSucceed: true)
        let viewModel = CandidatesRepository(apiService: mockApiService)

        viewModel.candidates = [candidate]

        // When
        await viewModel.deleteCandidate(id: candidate.id.uuidString)

        // Then
        XCTAssertTrue(viewModel.candidates.isEmpty, "Candidate have to be deleted")
    }

    func testDeleteCandidateFailure() async {
        // Given
        let candidateDTO = CandidateDTO(id: UUID(), firstName: "John", lastName: "Doe", email: "test@example.com", phone: "123456789", note: "Test", linkedinURL: "linkedin.com/in/johndoe", isFavorite: false)
        let candidate = Candidate(from: candidateDTO)

        let mockApiService = MockAPIService(shouldSucceed: false, error: URLError(.badServerResponse))
        let viewModel = CandidatesRepository(apiService: mockApiService)

        viewModel.candidates = [candidate]

        // When
        await viewModel.deleteCandidate(id: candidate.id.uuidString)

        // Then
        XCTAssertEqual(viewModel.candidates.count, 1, "Candidate should not be deleted")
    }
    
    // MARK: - Test updateFavorite
    
    func testUpdateFavoriteSuccess() async {
        // Given
        let candidateDTO = CandidateDTO(id: UUID(), firstName: "John", lastName: "Doe", email: "test@example.com", phone: "123456789", note: "Test", linkedinURL: "linkedin.com/in/johndoe", isFavorite: false)
        let candidate = Candidate(from: candidateDTO)

        let updatedCandidateDTO = CandidateDTO(id: candidate.id, firstName: candidate.firstName, lastName: candidate.lastName, email: candidate.email, phone: candidate.phone, note: candidate.note, linkedinURL: candidate.linkedinURL, isFavorite: true)
        
        let mockApiService = MockAPIService(shouldSucceed: true, response: updatedCandidateDTO)
        let viewModel = CandidatesRepository(apiService: mockApiService)

        viewModel.candidates = [candidate]

        // When
        await viewModel.updateFavorite(candidateId: candidate.id.uuidString)

        // Then
        XCTAssertEqual(viewModel.candidates.first?.isFavorite, true, "Candidate status updated")
    }

    func testUpdateFavoriteFailure() async {
        // Given
        let candidateDTO = CandidateDTO(id: UUID(), firstName: "John", lastName: "Doe", email: "test@example.com", phone: "123456789", note: "Test", linkedinURL: "linkedin.com/in/johndoe", isFavorite: false)
        let candidate = Candidate(from: candidateDTO)

        let mockApiService = MockAPIService(shouldSucceed: false, error: URLError(.badServerResponse))
        let viewModel = CandidatesRepository(apiService: mockApiService)

        viewModel.candidates = [candidate]

        // When
        await viewModel.updateFavorite(candidateId: candidate.id.uuidString)

        // Then
        XCTAssertEqual(viewModel.candidates.first?.isFavorite, false, "Candidate status not updated")
    }
}
