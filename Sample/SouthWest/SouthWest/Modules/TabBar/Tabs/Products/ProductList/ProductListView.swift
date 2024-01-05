//
//  ProductListView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 07/11/23.
//

import SwiftUI

struct ProductListView: View {
    
    @Binding var isSideMenuVisible: Bool
    
    var body: some View {
        
        NavigationView {
            VStack (spacing: 16) {
                ScrollView([.vertical], showsIndicators: false) {
                    
                    NavigationLink {
                        ProductDetailView()
                    } label: {
                        Image(Images.homeScreen)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .accessibilityIdentifier(Constants.AccessibilityIdentifiers.productsView)
                    }
                    .buttonStyle(NoTapEffectButtonStyle())
                    .accessibilityIdentifier(Constants.AccessibilityIdentifiers.productsView)
                }
            }
            .navigationBarTitle(Constants.Characters.emptyString, displayMode: .inline)
            .navigationBarHidden(false)
            .navigationBarItems(leading: ProductListNavigationItems(isSideMenuVisible: $isSideMenuVisible))
            .onAppear {
                UITabBar.setHidden(false)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.black)
        .navigationBarHidden(true) // Hide outer nav bar
    }
}

struct ProductListNavigationItems: View {
    
    @Binding var isSideMenuVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 0) {
                Button {
                    isSideMenuVisible = true
                } label: {
                    Image(Images.iconSideMenu)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .shadow(radius: 0.2)
                }
                VStack(alignment: .leading) {
                    Text(Constants.Products.navigationTitleWelcome)
                        .font(.system(size: 10))
                    Text(Constants.Products.navigationSubtitleUsername)
                        .font(.system(size: 12, weight: .semibold))
                    
                }
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(isSideMenuVisible: .constant(false))
    }
}
