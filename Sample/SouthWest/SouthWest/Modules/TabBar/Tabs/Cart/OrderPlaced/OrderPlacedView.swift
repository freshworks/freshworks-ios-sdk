//
//  OrderPlacedView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 08/11/23.
//

import SwiftUI

struct OrderPlacedView: View {
        
    var body: some View {
        VStack {
            
            Spacer()
            Image(Images.orderPlaced)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Button {
                // TODO: Go to home
            } label: {
                DarkButton(title: Constants.Cart.done)
            }
            .disabled(true)
        }
        .background(Color(Colors.backgroundGray))
    }
}

struct OrderPlacedView_Previews: PreviewProvider {
    static var previews: some View {
        OrderPlacedView()
    }
}
