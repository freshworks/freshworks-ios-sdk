//
//  ChangeAccountView.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 22/11/23.
//

import SwiftUI
import FreshworksSDK 

struct ChangeAccountView: View {
    
    let didDismiss: (_ sdkConfig: SDKConfig?) -> Void
    
    @State private var showAlert: Bool = false
    
    @State private var source: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.source) ?? Constants.Characters.emptyString
    @State private var appID: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.appID) ?? Constants.Characters.emptyString
    @State private var appKey: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.appKey) ?? Constants.Characters.emptyString
    @State private var domain: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.domain) ?? Constants.Characters.emptyString
    @State private var widgetID: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.widgetID) ?? Constants.Characters.emptyString
    @State private var jwt: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.jwt) ?? Constants.Characters.emptyString

    
    var body: some View {
        FeatureBackgroundView(
            heading: Constants.Features.LoadAccount.title,
            subheading: Constants.Features.LoadAccount.subheading,
            mainButtonTitle: Constants.Features.LoadAccount.mainButton,
            dismissTapped: {
                didDismiss(nil)
            }, mainButtonTapped: {
                updateButtonTapped()
            }, content: {
                
                FeatureTextfield(
                    title: Constants.Features.LoadAccount.appIdTitle,
                    placeholder: Constants.Features.LoadAccount.appIdPlaceholder,
                    content: $appID
                )
                FeatureTextfield(
                    title: Constants.Features.LoadAccount.appKeyTitle,
                    placeholder: Constants.Features.LoadAccount.appKeyPlaceholder,
                    content: $appKey
                )
                FeatureTextfield(
                    title: Constants.Features.LoadAccount.domainTitle,
                    placeholder: Constants.Features.LoadAccount.domainPlaceholder,
                    content: $domain
                )
                FeatureTextfield(
                    title: Constants.Features.LoadAccount.widgetSourceTitle,
                    placeholder: Constants.Features.LoadAccount.widgetSourcePlaceholder,
                    content: $source
                )
                FeatureTextfield(
                    title: Constants.Features.LoadAccount.widgetIdTitle,
                    placeholder: Constants.Features.LoadAccount.widgetIdPlaceholder,
                    content: $widgetID
                )
                FeatureTextfield(
                    title: Constants.Features.LoadAccount.authTokenTitle,
                    placeholder: Constants.Features.LoadAccount.authTokenPlaceholder,
                    content: $jwt
                )
                Text(Constants.Features.LoadAccount.footer)
                    .font(.system(size: 12))
                    .foregroundColor(Color(Colors.darkBlue).opacity(0.7))
            })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(Constants.Alert.title),
                message: Text(Constants.Features.LoadAccount.alertMessage),
                dismissButton: .default(Text(Constants.Alert.okay))
            )
        }
    }
    
    private func dismissAction() {
        didDismiss(nil)
    }
    
    private func updateButtonTapped() {
        guard !source.isEmpty && !appID.isEmpty && !appKey.isEmpty && !domain.isEmpty else {
            showAlert = true
            return
        }
        showAlert = false
        
        let sdkConfig =  SDKConfig(source: source,
                                   appID: appID,
                                   appKey: appKey,
                                   domain: domain,
                                   widgetId: widgetID,
                                   locale: Constants.Features.ChangeLanguage.defaultSelectedLanguageCode,
                                   jwtAuthToken: jwt)
        
        UserDefaults.standard.updateSDKConfig(sdkConfig, domain: domain)
        
        didDismiss(sdkConfig)
    }
}

struct ChangeAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeAccountView { _ in }
    }
}

