//
//  ProductDetailView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 07/11/23.
//

import SwiftUI
import FreshworksSDK

struct ProductDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var navigationItemsPaddingInsets = EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
    
    var body: some View {
        
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Image(Images.productImage)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image(Images.productOptions)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Button {
                        
                    } label: {
                        DarkButton(image: Images.iconAddToCart, title: Constants.Products.addToCart)
                    }
                    .disabled(true)
                }
            }
            
            VStack {
                HStack(spacing: 0) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(Images.iconBack)
                            .renderingMode(.template)
                            .frame(width: 48, height: 48)
                            .accentColor(.black)
                    }
                    Spacer()
                    Button {
                        if let topView = UIApplication.topView {
                            Freshworks.shared.showFAQs(topView)
                        }
                    } label: {
                        Image(Images.iconFAQsRound)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 48, height: 48)
                            .shadow(radius: 0.2)
                            .accessibilityIdentifier(Constants.AccessibilityIdentifiers.showFaqs)
                    }
                    .accessibilityIdentifier(Constants.AccessibilityIdentifiers.showFaqs)

                    Button {
                    } label: {
                        Image(Images.iconCartRound)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 48, height: 48)
                            .shadow(radius: 0.2)
                    }
                    .padding(navigationItemsPaddingInsets)
                    .disabled(true)
                }
                Spacer()
            }
        }
        .background(Color(Colors.backgroundGray))
        .navigationBarTitle(Constants.Characters.emptyString)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .onAppear {
            UITabBar.setHidden(true)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
    }
}
