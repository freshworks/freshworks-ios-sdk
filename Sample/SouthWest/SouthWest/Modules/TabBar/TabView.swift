//
//  TabView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 07/11/23.
//

import SwiftUI

struct CustomTabView: View {
    
    @State private var selection = 0
    @State private var isSideMenuVisible = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation

    var body: some View {
        
        ZStack() {
            TabView(selection: $selection) {
                ProductListView(isSideMenuVisible: $isSideMenuVisible)
                    .tabItem {
                        Image(selection == 0 ? Images.iconHomeFilled : Images.iconHome)
                    }
                    .tag(0)
                FavouritesView()
                    .tabItem {
                        Image(selection == 1 ? Images.iconFavouritesFilled : Images.iconFavourites)
                    }
                    .tag(1)
                CartView()
                    .tabItem {
                        Image(selection == 2 ? Images.iconCartFilled : Images.iconCart)
                    }
                    .tag(2)
            }

            if isSideMenuVisible {
                HStack(spacing: 0) {
                    SideMenuView(isSideMenuVisible: $isSideMenuVisible)
                        .edgesIgnoringSafeArea([.vertical])
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height)

                    Button {
                        isSideMenuVisible = false
                    } label: {
                        Rectangle()
                            .foregroundColor(.black.opacity(0.4))
                    }
                    .edgesIgnoringSafeArea([.all])
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            isSideMenuVisible = false
            orientation = UIDevice.current.orientation
        }
        
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
