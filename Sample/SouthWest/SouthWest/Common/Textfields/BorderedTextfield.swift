//
//  BorderedTextfield.swift
//  SouthWest
//
//  Created by Pramit Tewari on 07/11/23.
//

import SwiftUI

struct BorderedTextfield: View {
    
    var placeholder: String
    var textColor: Color = .white
    var borderColor: Color = .white
    @Binding var value: String
    
    var body: some View {
        if #available(iOS 15.0, *) {
            TextField(Constants.Characters.emptyString, text: $value, prompt: Text(placeholder).foregroundColor(.gray))
                .accessibilityIdentifier(placeholder)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(borderColor, lineWidth: 1)
                )
                .background(Color.clear)
                .foregroundColor(textColor)
        } else {
            ZStack(alignment: .leading) {
                TextField(Constants.Characters.emptyString, text: $value)
                    .accessibilityIdentifier(placeholder)
                    .foregroundColor(textColor)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(borderColor, lineWidth: 1)
                    )
                    .background(Color.clear)
                if value.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 5)
                }
            }
        }
    }
}

struct BorderedTextfield_Previews: PreviewProvider {
    static var previews: some View {
        BorderedTextfield(placeholder: Constants.PreviewProvider.sampleText, value: .constant(Constants.PreviewProvider.emptyText))
    }
}
