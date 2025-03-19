import SwiftUI

struct CandidatesListView: View {
    
    @StateObject var candidatesRepository = CandidatesRepository()
    @State var searchContent = ""
    @State var isDisplayFavoriteOnly = false
    @State var isEditing = false
    @State var isDisplayAddCandidatView = false
    @State var selectedCandidates: Set<UUID> = []
    @State var selectedCandidate: Candidate? = nil
    @State var isDetailViewPresented = false
    
    private var filteredCandidates: [Candidate] {
        candidatesRepository.candidates
            .filter { candidate in
                (!isDisplayFavoriteOnly || candidate.isFavorite) &&
                (searchContent.isEmpty || candidate.firstName.lowercased().contains(searchContent.lowercased()) || candidate.lastName.lowercased().contains(searchContent.lowercased()))
            }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(filteredCandidates) { candidate in
                                HStack {
                                    if isEditing {
                                        Image(systemName: selectedCandidates.contains(candidate.id) ? "checkmark.circle.fill" : "circle")
                                            .foregroundStyle(selectedCandidates.contains(candidate.id) ? .red : .gray)
                                            .onTapGesture {
                                                toggleSelection(candidate.id)
                                            }
                                            .padding(.trailing)
                                    }
                                    
                                    CandidateRowView(candidateFavorite: candidatesRepository, candidate: candidate)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            if !isEditing {
                                                selectedCandidate = candidate
                                                isDetailViewPresented = true
                                            }
                                        }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                    .navigationTitle("Liste des candidats")
                    .navigationBarTitleDisplayMode(.inline)
                    .searchable(text: $searchContent)
                    .refreshable {
                        await candidatesRepository.fetchCandidatesList()
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                withAnimation {
                                    isEditing.toggle()
                                    selectedCandidates.removeAll()
                                }
                            } label: {
                                Text(isEditing ? "Terminer" : "Éditer")
                                    .foregroundStyle(Color("AppColor"))
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            if isEditing {
                                if !selectedCandidates.isEmpty {
                                    Button {
                                        Task {
                                            for id in selectedCandidates {
                                                await candidatesRepository.deleteCandidate(id: "\(id)")
                                            }
                                            selectedCandidates.removeAll()
                                            isEditing.toggle()
                                        }
                                    } label: {
                                        Text("Supprimer")
                                            .foregroundStyle(.red)
                                    }
                                }
                            } else if AdminManager.shared.isAdmin {
                                Button {
                                    isDisplayFavoriteOnly.toggle()
                                } label: {
                                    Image(systemName: isDisplayFavoriteOnly ? "star.fill" : "star")
                                }
                            }
                        }
                    }
                }
                
                if isEditing {
                    VStack {
                        Spacer()
                        Button {
                            isDisplayAddCandidatView.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 64))
                                .foregroundStyle(.blue)
                                .shadow(radius: 5)
                        }
                        .padding(.bottom, 30)
                    }
                    .ignoresSafeArea()
                }
            }
            .sheet(isPresented: $isDisplayAddCandidatView) {
                AddCandidatView(candidatesRepository: candidatesRepository)
            }
            .navigationDestination(isPresented: $isDetailViewPresented) {
                if let selectedCandidate {
                    CandidateDetailView(updateCandidate: candidatesRepository, candidate: selectedCandidate)
                }
            }
            .task {
                await candidatesRepository.fetchCandidatesList()
            }
        }
    }
    
    private func toggleSelection(_ id: UUID) {
        if selectedCandidates.contains(id) {
            selectedCandidates.remove(id)
        } else {
            selectedCandidates.insert(id)
        }
    }
}

#Preview {
    CandidatesListView()
}
