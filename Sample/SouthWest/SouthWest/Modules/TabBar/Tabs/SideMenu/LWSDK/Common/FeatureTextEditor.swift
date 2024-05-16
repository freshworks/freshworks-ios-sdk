//
//  FeatureTextEditor.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 28/12/23.
//

import SwiftUI

struct FeatureTextEditor: View {
    var title: String
    var placeholder: String
    var description: String? = nil
    
    @Binding var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 13))
            
            if let description = description {
                Text(description)
                    .font(.caption2)
            }
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $content)
                    .frame(height: 140)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.vertical, 4)
                    .font(.system(size: 13))
                if content.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .font(.system(size: 13))
                        .padding(12)
                }
            }
            .accentColor(.black) // Set the tint color
            .accessibilityIdentifier(title)
        }
        .padding()
    }
}


struct FeatureTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        FeatureTextEditor(title: Constants.PreviewProvider.sampleText, placeholder: Constants.PreviewProvider.sampleText, content: .constant(Constants.PreviewProvider.emptyText))
    }
}
