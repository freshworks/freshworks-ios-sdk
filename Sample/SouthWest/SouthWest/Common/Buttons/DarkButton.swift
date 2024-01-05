//
//  DarkButton.swift
//  SouthWest
//
//  Created by Pramit Tewari on 08/11/23.
//

import SwiftUI

struct DarkButton: View {
    var image: String? = nil
    var title: String
    
    var body: some View {
        HStack {
            Spacer()
            if let image = image {
                Image(image)
            }
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
            Spacer()
        }
        .frame(height: 50)
        .background(Color(Colors.darkBlue))
        .cornerRadius(25)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}

struct DarkButton_Previews: PreviewProvider {
    static var previews: some View {
        DarkButton(image: nil, title: Constants.PreviewProvider.sampleText)
    }
}
