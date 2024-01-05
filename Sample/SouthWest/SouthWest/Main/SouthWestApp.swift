//
//  SouthWestApp.swift
//  SouthWest
//
//  Created by Pramit Tewari on 06/11/23.
//

import SwiftUI

@main
struct SouthWestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        setNavigationBarProperties()
    }
    
    func setNavigationBarProperties() {
        let appearance = UINavigationBarAppearance()
        let backImage = UIImage(named: Images.iconBack)
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        
        let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        backButtonAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.clear]
        backButtonAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.clear]
        backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]

        appearance.backButtonAppearance = backButtonAppearance

        UINavigationBar.appearance().standardAppearance = appearance

    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.colorScheme, .light)
        }
    }
}
