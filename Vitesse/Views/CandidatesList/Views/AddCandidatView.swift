import SwiftUI

struct AddCandidatView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var candidatesRepository : CandidatesRepository
    @State var email = ""
    @State var note = ""
    @State var linkedinURL = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var phone = ""
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundColor(Color("AppColor"))
                        .padding()
                }
                Spacer()
            }
            
            ScrollView {
                VStack(spacing: 12) {
                    VStack(spacing: 0) {
                        OnboardingInputField(title: "Email", placeholder: "Entrez votre email", text: $email)
                        
                        OnboardingInputField(title: "Prénom", placeholder: "Entrez votre prénom", text: $firstName)
                        
                        OnboardingInputField(title: "Nom", placeholder: "Entrez votre nom", text: $lastName)
                        
                        OnboardingInputField(title: "Téléphone", placeholder: "0102030405", text: $phone)
                        
                        OnboardingInputField(title: "LinkedIn", placeholder: "John Doe", text: $linkedinURL)
                        
                        OnboardingInputField(title: "Note", placeholder: "Ajouter une note", isNote: true, text: $note)
                    }
                    
                    OnboardingButton(title: "Ajouter un candidat") {
                        await candidatesRepository.addCandidate(email: email, note: note, linkedinURL: linkedinURL, firstName: firstName, lastName: lastName, phone: phone)
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
