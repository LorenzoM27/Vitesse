//
//  CandidatesListViewModel.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 08/02/2025.
//

import Foundation

@MainActor
final class CandidatesRepository: ObservableObject {
    
//    @Published var email = ""
//    @Published var note = ""
//    @Published var linkedinURL = ""
//    @Published var firstName = ""
//    @Published var lastName = ""
//    @Published var phone = ""
//    
    @Published var candidates: [Candidate] = []
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func fetchCandidatesList() async {
        let endpoint = APIEndpoint.getCandidates
        
        do {
            let candidatesListResponse: [CandidateDTO] = try await apiService.request(endpoint: endpoint)
            self.candidates = candidatesListResponse.map { Candidate(from: $0) }
        } catch {
            print("Error : Impossible to fetch candidates list \(error.localizedDescription)")
        }
    }
    
    func addCandidate(email : String, note: String?, linkedinURL: String?, firstName: String, lastName: String, phone: String) async {
        let endpoint = APIEndpoint.createCandidate(email: email, firstName: firstName, lastName: lastName, phone: phone, note: note, linkedinURL: linkedinURL)
        
        do {
            let newCandidateDTO: CandidateDTO = try await apiService.request(endpoint: endpoint)
            let newCandidate = Candidate(from: newCandidateDTO)
            
            candidates.insert(newCandidate, at: 0)
            print("Candidat ajouté :", newCandidate)
        } catch {
            print("Error : Impossible d'ajouter un candidat \(error.localizedDescription)")
        }
    }
    
    func deleteCandidate(id: String) async {
        let endpoint = APIEndpoint.deleteCandidate(candidateId: id)
        print("ID du candidat : \(id)")
        
        do {
            try await apiService.requestWithoutReturn(endpoint: endpoint)
            candidates.removeAll { $0.id.uuidString == id }
        } catch {
            print("Error : Impossible to delete : \(error.localizedDescription)")
        }
    }
    
    
    func updateFavorite(candidateId: String) async {
        let endpoint = APIEndpoint.updateFavoriteStatus(candidateId: candidateId)
        print("ID du candidat : \(candidateId)")
        
        do {
            let updatedCandidateDTO : CandidateDTO = try await apiService.request(endpoint: endpoint)
            let updatedCandidate = Candidate(from: updatedCandidateDTO)
            
            if let index = candidates.firstIndex(where: { $0.id == updatedCandidate.id }) {
                        candidates[index] = updatedCandidate
                    }
            
            print(updatedCandidate)
        } catch {
            print("Error : Impossible de modifier le favoris \(error.localizedDescription)")
        }
    }
}
