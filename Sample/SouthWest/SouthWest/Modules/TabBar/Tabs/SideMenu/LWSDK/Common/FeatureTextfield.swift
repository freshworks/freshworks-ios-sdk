//
//  FeatureTextfield.swift
//  SouthWest
//
//  Created by Pramit Tewari on 07/12/23.
//

import SwiftUI

struct FeatureTextfield: View {
    
    var title: String
    var placeholder: String
    var description: String? = nil
    
    @Binding var content: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 13))
            if let description = description  {
                Text(description)
                    .font(.caption2)
            }
            TextField(placeholder, text: $content)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 17))
                .accessibilityIdentifier(title)
        }
    }
}

struct FeatureTextfield_Previews: PreviewProvider {
    static var previews: some View {
        FeatureTextfield(title: Constants.PreviewProvider.sampleText, placeholder: Constants.PreviewProvider.sampleText, content: .constant(Constants.PreviewProvider.emptyText))
    }
}
