//
//  CandidateRowView.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 11/02/2025.
//

import SwiftUI

struct CandidateRowView: View {
    
    @ObservedObject var candidateFavorite : CandidatesRepository
    let candidate : Candidate
    
    var body: some View {
        HStack {
            Text("\(candidate.firstName) \(candidate.lastName)")
            Spacer()
            
            if AdminManager.shared.isAdmin {
                Button {
                    Task {
                       await candidateFavorite.updateFavorite(candidateId: "\(candidate.id)")
                    }
                } label: {
                    Image(systemName: candidate.isFavorite ? "star.fill": "star")
                }
               .buttonStyle(.plain)

            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("AppColor"), lineWidth: 2)
        )
    }
}

//#Preview {
//    CandidateRowView(candidateFavorite: CandidatesRepository(), candidate: candidateFavorite.candidates[0])
//}
