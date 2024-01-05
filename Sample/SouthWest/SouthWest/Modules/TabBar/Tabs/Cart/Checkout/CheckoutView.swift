//
//  CheckoutView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 08/11/23.
//

import SwiftUI

struct CheckoutView: View {
    
    @State private var email: String = Constants.Characters.emptyString
    @State private var password: String = Constants.Characters.emptyString
    
    var body: some View {
        VStack {
            VStack {
                ReturningCustomerView(email: $email, password: $password)
                    .padding()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
           
            VStack {
                GuestView()
                    .padding()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            Spacer()
        }
        
        .background(Color(Colors.backgroundDarkGray))
        .navigationBarTitle(Constants.Cart.checkout, displayMode: .inline)
        .onAppear {
            UITabBar.setHidden(true)
        }
    }
}

struct ReturningCustomerView: View {
    
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            
            VStack (alignment: .leading, spacing: 8) {
                Text(Constants.Cart.returningCustomer)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(Colors.darkBlue))
                Text(Constants.Cart.fasterCheckout)
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)

            }
            
            VStack (alignment: .leading, spacing: 2) {
                Text(Constants.Login.email)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color(Colors.darkBlue))
                BorderedTextfield(placeholder: "", textColor: .black, borderColor: .black, value: $email)
            }
            
            VStack (alignment: .leading, spacing: 2) {
                Text(Constants.Login.password)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color(Colors.darkBlue))
                BorderedTextfield(placeholder: Constants.Characters.emptyString, textColor: .black, borderColor: .black, value: $password)
            }
            
            NavigationLink {
                OrderPlacedView()
            } label: {
                DarkButton(title: Constants.Cart.continueButton)
            }
        }
    }
}

struct GuestView: View {
        
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            
            VStack (alignment: .leading, spacing: 8) {
                Text(Constants.Cart.guest)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(Colors.darkBlue))
                Text(Constants.Cart.loginNotNeeded)
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)

            }
            NavigationLink {
                OrderPlacedView()
            } label: {
                DarkButton(title: Constants.Cart.continueButton)
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
