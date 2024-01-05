//
//  UserDetails.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 21/11/23.
//

import Foundation
import FreshworksSDK

struct UserDetails: Codable {
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    var phoneCountry: String?
    var customProperties: [String: String]

    init(firstName: String? = nil,
         lastName: String? = nil,
         email: String? = nil,
         phone: String? = nil,
         phoneCountry: String? = nil,
         customProperties: [String: String] = [:]) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.phoneCountry = phoneCountry
        self.customProperties = customProperties
    }
}

// Extension to reset UserDefaults
extension UserDefaults {
    func resetUserDetails() {
        //User details
        removeObject(forKey: Constants.UserDefaultsKeys.userDetails)
        
        //Identify user
        removeObject(forKey: Constants.UserDefaultsKeys.externalID)
        removeObject(forKey: Constants.UserDefaultsKeys.restoreID)
        
        //Locale change
        removeObject(forKey: Constants.UserDefaultsKeys.selectedWidgetLanguageLocaleCode)
        removeObject(forKey: Constants.UserDefaultsKeys.selectedUserLanguageLocaleCode)
        
        //Parallel conversation
        removeObject(forKey: Constants.UserDefaultsKeys.conversationReferenceId)
        removeObject(forKey: Constants.UserDefaultsKeys.topicNameForConversationReferenceId)
        
        //Tags
        removeObject(forKey: Constants.UserDefaultsKeys.tags)
        removeObject(forKey: Constants.UserDefaultsKeys.tagsSelectOption)
        
        //Jwt
        removeObject(forKey: Constants.UserDefaultsKeys.jwt)
    }
}

// Extension to UserDefaults to simplify storing and retrieving UserDetails
extension UserDefaults {
    func setUserDetails(_ userDetails: UserDetails?, forKey key: String = Constants.UserDefaultsKeys.userDetails) {
        guard let userDetails = userDetails else {
            removeObject(forKey: key)
            return
        }

        do {
            let encodedData = try PropertyListEncoder().encode(userDetails)
            set(encodedData, forKey: key)
        } catch {
            print("Error encoding user details: \(error)")
        }
    }

    func getUserDetails() -> UserDetails? {
        guard let encodedData = data(forKey: Constants.UserDefaultsKeys.userDetails) else {
            return nil
        }

        do {
            let userDetails = try PropertyListDecoder().decode(UserDetails.self, from: encodedData)
            return userDetails
        } catch {
            print("Error decoding user details: \(error)")
            return nil
        }
    }
    
    func updateSDKConfig(_ sdkConfig: SDKConfig) {
        UserDefaults.standard.set(sdkConfig.source, forKey: Constants.UserDefaultsKeys.source)
        UserDefaults.standard.set(sdkConfig.appId, forKey: Constants.UserDefaultsKeys.appID)
        UserDefaults.standard.set(sdkConfig.appKey, forKey: Constants.UserDefaultsKeys.appKey)
        UserDefaults.standard.set(sdkConfig.domain, forKey: Constants.UserDefaultsKeys.domain)
        UserDefaults.standard.set(sdkConfig.widgetId, forKey: Constants.UserDefaultsKeys.widgetID)
        UserDefaults.standard.set(sdkConfig.jwtAuthToken, forKey: Constants.UserDefaultsKeys.jwt)
    }
    
    func updateJWT(_ jwt: String) {
        UserDefaults.standard.set(jwt, forKey: Constants.UserDefaultsKeys.jwt)
    }
    
    func getSDKConfig() -> SDKConfig? {
        guard let source =  UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.source),
              let appID =  UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.appID),
              let appKey =  UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.appKey),
              let domain =  UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.domain),
              let widgetID =  UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.widgetID),
              let jwt =  UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.jwt) else {
            return nil
        }
        
        guard !source.isEmpty && !appID.isEmpty && !appKey.isEmpty && !domain.isEmpty else {
            return nil
        }
        
        let sdkConfig = SDKConfig(source: source,
                                  appID: appID,
                                  appKey: appKey,
                                  domain: domain,
                                  widgetId: widgetID,
                                  jwtAuthToken: jwt)
        return sdkConfig
    }
}

