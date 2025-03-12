import SwiftUI

struct AddCandidatView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var candidatesRepository : CandidatesRepository
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                }
                Spacer()
            }
            
            ScrollView {
                VStack(spacing: 12) {
                    VStack(spacing: 0) {
                        OnboardingInputField(title: "Email", placeholder: "Entrez votre email", text: $candidatesRepository.email)
                        
                        OnboardingInputField(title: "Prénom", placeholder: "Entrez votre prénom", text: $candidatesRepository.firstName)
                        
                        OnboardingInputField(title: "Nom", placeholder: "Entrez votre nom", text: $candidatesRepository.lastName)
                        
                        OnboardingInputField(title: "Téléphone", placeholder: "0102030405", text: $candidatesRepository.phone)
                        
                        OnboardingInputField(title: "LinkedIn", placeholder: "John Doe", text: $candidatesRepository.linkedinURL)
                        
                        OnboardingInputField(title: "Note", placeholder: "Ajouter une note", isNote: true, text: $candidatesRepository.note)
                    }
                    
                    OnboardingButton(title: "Ajouter un candidat") {
                        await candidatesRepository.addCandidate()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    AddCandidatView(candidatesRepository: CandidatesRepository())
}
