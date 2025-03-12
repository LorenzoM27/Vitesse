import SwiftUI

struct EditableFieldView: View {
    let label: String
    @Binding var value: String
    let isEditing: Bool

    var body: some View {
        HStack {
            Text("\(label) : ")
                .fontWeight(.semibold)
            if isEditing {
                TextField(label, text: $value)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(value.isEmpty ? "Non renseigné" : value)
            }
        }
        .padding(.bottom, 18)
    }
}