//
//  CandidatesListViewModel.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 08/02/2025.
//

import Foundation

@MainActor
final class CandidatesRepository: ObservableObject {//Repository
    
    @Published var email = ""
    @Published var note = ""
    @Published var linkedinURL = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phone = ""
    
    @Published var candidatesList: [CandidateDTO] = []//Créer un autre model, celui la seulement pour récupérer les données
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    
    func fetchCandidatesList() async {
        
        let endpoint = APIEndpoint.getCandidates
        
        do {
            let candidatesListResponse: [CandidateDTO] = try await apiService.request(endpoint: endpoint)
            print("Réponse reçue :", candidatesListResponse)
            candidatesList = candidatesListResponse
        } catch {
            print("Error : Imposible to fetch candidates list \(error.localizedDescription)")
        }
    }
    
    
    func addCandidat() async {
        let endpoint = APIEndpoint.createCandidate(email: email, firstName: firstName, lastName: lastName, phone: phone, note: note, linkedinURL: linkedinURL)
        
        do {
            let addCandidatResponse : [CandidateDTO] = try await apiService.request(endpoint: endpoint)
            candidatesList = addCandidatResponse
            print("Réponse reçue :", addCandidatResponse)
            print("Réponse :", candidatesList)
        } catch {
            print("Error : Imposible to add candidates \(error.localizedDescription)")
        }
    }
}
