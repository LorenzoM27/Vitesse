//
//  CandidateDetailViewModelTests.swift
//  CandidateDetailViewModelTests
//
//  Created by Lorenzo Menino on 12/03/2025.
//


import XCTest
@testable import Vitesse

@MainActor
final class CandidateDetailViewModelTests: XCTestCase {
    
    func testFetchCandidateDetailSuccess() async {
        // Given
        let candidateDTO = CandidateDTO(
            id: UUID(), firstName: "John", lastName: "Doe", email: "john.doe@example.com",
            phone: "123456789", note: "Good candidate", linkedinURL: "https://linkedin.com/john", isFavorite: false
        )
        let mockAPIService = MockAPIService(response: candidateDTO)
        let viewModel = CandidateDetailViewModel(apiService: mockAPIService)
        
        // When
        await viewModel.fetchCandidateDetail(id: candidateDTO.id.uuidString)
        
        // Then
        XCTAssertEqual(viewModel.candidateDetail.id, candidateDTO.id)
        XCTAssertEqual(viewModel.candidateDetail.firstName, "John")
        XCTAssertEqual(viewModel.candidateDetail.lastName, "Doe")
        XCTAssertEqual(viewModel.candidateDetail.email, "john.doe@example.com")
    }
    
    func testFetchCandidateDetailFailure() async {
        // Given
        let mockAPIService = MockAPIService(shouldSucceed: false, error: URLError(.badServerResponse))
        let viewModel = CandidateDetailViewModel(apiService: mockAPIService)
        
        // When
        await viewModel.fetchCandidateDetail(id: UUID().uuidString)
        
        // Then
        XCTAssertEqual(viewModel.candidateDetail.firstName, "")
        XCTAssertEqual(viewModel.candidateDetail.lastName, "")
    }
    
    func testUpdateCandidateSuccess() async {
        // Given
        let updatedCandidateDTO = CandidateDTO(
            id: UUID(), firstName: "John", lastName: "Doe", email: "john.doe@example.com",
            phone: "987654321", note: "Updated note", linkedinURL: "https://linkedin.com/john", isFavorite: true
        )
        let mockAPIService = MockAPIService(response: updatedCandidateDTO)
        let viewModel = CandidateDetailViewModel(apiService: mockAPIService)
        
        // When
        await viewModel.updateCandidate(
            id: updatedCandidateDTO.id.uuidString, firstName: "John", lastName: "Doe",
            phone: "987654321", email: "john.doe@example.com", linkedinURL: "https://linkedin.com/john",
            note: "Updated note"
        )
        
        // Then
        XCTAssertEqual(viewModel.candidateDetail.firstName, "John")
        XCTAssertEqual(viewModel.candidateDetail.lastName, "Doe")
        XCTAssertEqual(viewModel.candidateDetail.phone, "987654321")
        XCTAssertEqual(viewModel.candidateDetail.note, "Updated note")
    }
    
    func testUpdateCandidateFailure() async {
        // Given
        let mockAPIService = MockAPIService(shouldSucceed: false, error: URLError(.badServerResponse))
        let viewModel = CandidateDetailViewModel(apiService: mockAPIService)
        
        // When
        await viewModel.updateCandidate(
            id: UUID().uuidString, firstName: "John", lastName: "Doe",
            phone: "987654321", email: "john.doe@example.com", linkedinURL: "https://linkedin.com/john",
            note: "Updated note"
        )
        
        // Then
        XCTAssertEqual(viewModel.candidateDetail.firstName, "")
        XCTAssertEqual(viewModel.candidateDetail.lastName, "")
    }
}
