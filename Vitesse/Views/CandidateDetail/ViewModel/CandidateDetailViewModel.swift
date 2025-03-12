//
//  CandidateDetailViewModel.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 18/02/2025.
//

import Foundation

@MainActor
final class CandidateDetailViewModel: ObservableObject {
    
    @Published var candidateDetail : Candidate
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
        self.candidateDetail = Candidate(from: CandidateDTO(id: UUID(), firstName: "", lastName: "", email: "", phone: "", note: "", linkedinURL: "", isFavorite: false))
    }
    
    
    func fetchCandidateDetail(id: String) async {
        
        let endpoint = APIEndpoint.getCandidateDetail(candidateId: id)
        
        do {
            let candidateDTO: CandidateDTO = try await apiService.request(endpoint: endpoint)
            self.candidateDetail = Candidate(from: candidateDTO)
            
        } catch {
            print("Error : Imposible to fetch candidate :\(error.localizedDescription)")
        }
    }
    
    func updateCandidate(id: String, firstName: String, lastName: String, phone: String?, email: String, linkedinURL: String?, note: String?) async {
           
        let endpoint = APIEndpoint.updateCandidate(candidateId: id, email: email, firstName: firstName, lastName: lastName, phone: phone, note: note, linkedinURL: linkedinURL)
           
           do {
               let updateCandidate: CandidateDTO = try await apiService.request(endpoint: endpoint)
               self.candidateDetail = Candidate(from: updateCandidate)
               print("Candidate updated")
           } catch {
               print("Error : Impossible to update candidate : \(error.localizedDescription)")
           }
       }
    
}
