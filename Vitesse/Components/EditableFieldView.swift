//
//  EditableFieldView.swift
//  Vitesse
//
//  Created by Lorenzo Menino on 26/02/2025.
//


import SwiftUI

struct EditableFieldView: View {
    
    let title: String
    let label: String
    @Binding var value: String
    let isEditing: Bool
    var isNote: Bool = false
    
    var body: some View {
        if isEditing {
            VStack(alignment: .leading) {
                Text("\(title) :")
                
                if !isNote {
                    TextField(label, text: $value)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    ZStack(alignment: .topLeading) {
                        
                        Text(label)
                            .foregroundColor(.gray)
                            .padding(10)
                        
                        
                        TextEditor(text: $value)
                            .frame(height: 150)
                            .padding(10)
                            .background(Color.clear) // Supprime le fond du TextEditor
                            .scrollContentBackground(.hidden) // Supprime l'arrière-plan flou (iOS 16+)
                    }
                    .padding(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                
            }
        } else {
            if !isNote {
                HStack {
                    Text("\(title) :")
                    Text(label)
                }
                
            } else {
                VStack(alignment: .leading, spacing: 12) {
                    Text("\(title) :")
                    
                    if !label.isEmpty {
                        Text(label)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    
                }
            }
        }
    }
}
