//
//  SideMenuView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 08/11/23.
//

import SwiftUI
import FreshworksSDK

struct SideMenuView: View {
    
    @Binding var isSideMenuVisible: Bool
    @State private var unreadCount: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    
    var body: some View {
        VStack (spacing: 0) {
            UserView()
            ScrollView {
                VStack (alignment: .leading) {
                    ForEach(SideMenuData.sideMenuItems) { item in
                        
                        switch item.title {
                        case Constants.SideMenu.myOrders:
                            NavigationLink {
                                MyOrdersView()
                            } label: {
                                SideMenuItemView(item: item)
                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                                    .accessibilityIdentifier(Constants.AccessibilityIdentifiers.myOrders)
                            }
                            .accessibilityIdentifier(Constants.AccessibilityIdentifiers.myOrders)
                            
                        case Constants.SideMenu.settings:
                            NavigationLink {
                                LWSDKFeaturesView()
                            } label: {
                                SideMenuItemView(item: item)
                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                                    .accessibilityIdentifier(Constants.AccessibilityIdentifiers.myOrders)
                            }
                            .accessibilityIdentifier(Constants.AccessibilityIdentifiers.myOrders)
                            
                        case Constants.SideMenu.contactUs:
                            Button {
                                showConversations()
                            } label: {
                                UnreadCountItemView(item: item, unreadCount: $unreadCount)
                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                                    .accessibilityIdentifier(Constants.AccessibilityIdentifiers.contactUs)
                            }
                            .accessibilityIdentifier(Constants.AccessibilityIdentifiers.contactUs)
                            
                            
                        default:
                            SideMenuItemView(item: item)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                    
                    Text("\(Constants.SideMenu.SDKVersionTitle)\(Freshworks.shared.getSDKVersion())")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(Colors.darkBlue))
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(Images.iconLogout)
                            Text(Constants.SideMenu.logout)
                                .foregroundColor(.red)
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                    }
                }
                .padding()
                .onAppear {
                    updateUnreadCount(Freshworks.shared.getUnreadCount())
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name(Constants.SideMenu.unreadNotificationName))) { info in
                    guard  let count = info.object as? Int else {
                        return
                    }
                    updateUnreadCount(count)
                }
                
                Spacer()
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .onDisappear {
            // isSideMenuVisible = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            orientation = UIDevice.current.orientation
            isSideMenuVisible = true
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: FWEvents.unreadCount.rawValue))) { notification in
            guard let unreadCount = notification.object as? Int else { return }
            updateUnreadCount(unreadCount)
        }

    }
    
    func showConversations() {
        if let topView = UIApplication.topView {
            Freshworks.shared.showConversations(topView)
        }
    }
    
    func updateUnreadCount(_ count: Int) {
        let formattedCount = count > 9 ? "9+" : "\(count)"
        unreadCount = count > 0 ? formattedCount : Constants.Characters.emptyString
    }
}

struct UserView: View {
    var body: some View {
        
        HStack(spacing: 0) {
            Image(Images.userImage)
                .padding()
            VStack (alignment: .leading) {
                Text(Constants.SideMenu.userName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                Text(Constants.SideMenu.userEmail)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        .background(Color(Colors.darkBlue))
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isSideMenuVisible: .constant(true))
    }
}

