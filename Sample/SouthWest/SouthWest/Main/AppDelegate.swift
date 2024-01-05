//
//  AppDelegate.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 21/11/23.
//

import Foundation
import SwiftUI
import FreshworksSDK

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeFreshworksSDK()
        registerNotifications()
        return true
    }
    
    func initializeFreshworksSDK() {
        if let sdkConfig =  UserDefaults.standard.getSDKConfig() {
            Freshworks.shared.initializeFreshworksSDK(with:sdkConfig)
        } else {
            let sdkConfig =  SDKConfig(source: Configurations.Account.source,
                                       appID: Configurations.Account.appID,
                                       appKey: Configurations.Account.appKey,
                                       domain: Configurations.Account.domain)
            Freshworks.shared.initializeFreshworksSDK(with:sdkConfig)
            UserDefaults.standard.updateSDKConfig(sdkConfig)
        }
        
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func registerNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Handle authorization status
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Freshworks.shared.setPushRegistrationToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register device token")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if Freshworks.shared.isFreshworksNotification(userInfo) {
            Freshworks.shared.handleRemoteNotification(userInfo) {
                completionHandler()
            }
        } else {
            completionHandler()
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if Freshworks.shared.isFreshworksNotification(userInfo) {
            Freshworks.shared.handleRemoteNotification(userInfo) {
                completionHandler( [.banner, .badge, .sound])
            }
        } else {
            completionHandler( [.banner, .badge, .sound])
        }
    }
}

