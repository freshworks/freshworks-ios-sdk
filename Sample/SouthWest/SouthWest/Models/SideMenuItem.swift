//
//  SideMenuItem.swift
//  SouthWest
//
//  Created by Pramit Tewari on 08/11/23.
//

import Foundation

struct SideMenuItem: Hashable, Identifiable {
    
    var id = UUID()
    var title: String
    var description: String
}

struct SideMenuData {
    
    static var previewItem: SideMenuItem = SideMenuItem(
        title: Constants.SideMenu.contactUs,
        description: Constants.SideMenu.contactUsDescription
    )
    
    static var sideMenuItems = [
        
        SideMenuItem(
            title: Constants.SideMenu.myOrders,
            description: Constants.SideMenu.myOrdersDescription
        ),
        
        SideMenuItem(
            title: Constants.SideMenu.shippingAddresses,
            description: Constants.SideMenu.shippingAddressesDescription
        ),
        
        SideMenuItem(
            title: Constants.SideMenu.paymentMethod,
            description: Constants.SideMenu.paymentMethodDescription
        ),
        
        SideMenuItem(
            title: Constants.SideMenu.readMore,
            description: Constants.SideMenu.readMoreDescription
        ),
        
        SideMenuItem(
            title: Constants.SideMenu.contactUs,
            description: Constants.SideMenu.contactUsDescription
        ),
        
        SideMenuItem(
            title: Constants.SideMenu.myReview,
            description: Constants.SideMenu.myReviewDescription
        ),
        
        SideMenuItem(
            title: Constants.SideMenu.settings,
            description: Constants.SideMenu.settingsDescription
        )
    ]
}
