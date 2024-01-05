//
//  CartView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 07/11/23.
//

import SwiftUI

struct CartView: View {
        
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Spacer()
                    NavigationLink {
                        CheckoutView()
                    } label: {
                        DarkButton(image: Images.checkoutArrow, title: Constants.Cart.checkout)
                    }
                    Spacer()
                    Image(Images.cartList)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .background(Color(Colors.backgroundGray))
            .navigationBarTitle(Constants.Cart.cart, displayMode: .inline)
            .onAppear {
                UITabBar.setHidden(false)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.black)
        .navigationBarHidden(true) // Hide outer nav bar
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
