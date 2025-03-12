//
//  CandidateDetailView.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 18/02/2025.
//

import SwiftUI

struct CandidateDetailView: View {
    
    @StateObject var candidateDetail = CandidateDetailViewModel()
    @ObservedObject var updateCandidate: CandidatesRepository
    @State var isEditing = false
    //let id : String
    let candidate : Candidate
    @State var phone = ""
    @State var email = ""
    @State var note = ""
    @State var linkedinURL = ""
    
    @State var errorMessage = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text((candidateDetail.candidateDetail.firstName) + " " + (candidateDetail.candidateDetail.lastName))
                    .font(.title)
                Spacer()
                Button {
                    if AdminManager.shared.isAdmin {
                        Task {
                            await updateCandidate.updateFavorite(candidateId: "\(candidate.id)")
                        }
                    }
                } label: {
                    if candidate.isFavorite {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                   
                }

                
            }
            .padding(.bottom, 24)
            
           
            VStack(alignment: .leading, spacing: 25) {
                
                EditableFieldView(title: "Téléphone", label: "\(candidateDetail.candidateDetail.phone)", value: $phone, isEditing: isEditing)
                
                EditableFieldView(title: "Email", label: "\(candidateDetail.candidateDetail.email)", value: $email, isEditing: isEditing)
                
                EditableFieldView(title: "LinkedIn", label: "\(candidateDetail.candidateDetail.linkedinURL ?? "")", value: $linkedinURL, isEditing: isEditing)
                
                EditableFieldView(title: "Note", label: "\(candidateDetail.candidateDetail.note ?? "")", value: $note, isEditing: isEditing, isNote: true)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .font(.callout)
                }
                
            }
            .padding()
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if !isEditing {
                        withAnimation {
                            isEditing.toggle()
                        }
                    } else if phone.isEmpty || email.isEmpty {
                        errorMessage = "téléphone et email obligatoire"
                    } else {
                        Task {
                            await candidateDetail.updateCandidate(id: "\(candidate.id)", firstName: candidateDetail.candidateDetail.firstName, lastName: candidateDetail.candidateDetail.lastName, phone: phone, email: email, linkedinURL: linkedinURL, note: note)
                        }
                        errorMessage = ""
                        withAnimation {
                            isEditing.toggle()
                        }
                    }
                } label: {
                    Text(isEditing ? "Terminer" : "Éditer")
                        .foregroundStyle(.black)
                }
            }
        }
        .padding()
        .task {
            await candidateDetail.fetchCandidateDetail(id: "\(candidate.id)")
        }
    }
}

//#Preview {
//    CandidateDetailView(id: "")
//}
