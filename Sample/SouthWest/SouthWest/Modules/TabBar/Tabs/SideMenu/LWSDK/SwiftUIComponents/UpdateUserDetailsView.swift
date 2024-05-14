//
//  UpdateUserDetailsView.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 21/11/23.
//

import SwiftUI

struct UpdateUserDetailsView: View {
    let didDismiss: (UserDetails?) -> Void

    @State private var firstName: String
    @State private var lastName: String
    @State private var email: String
    @State private var phone: String
    @State private var phoneCountry: String
    @State private var customPropertiesString: String
    @State private var customProperties: [String: String]
    
    
    init(_ didDismiss: @escaping (UserDetails?) -> Void) {
        self.didDismiss = didDismiss
        
        let userDetails = UserDefaults.standard.getUserDetails()
            
        firstName = userDetails?.firstName ?? Constants.Characters.emptyString
        lastName = userDetails?.lastName ?? Constants.Characters.emptyString
        email = userDetails?.email ?? Constants.Characters.emptyString
        phone = userDetails?.phone ?? Constants.Characters.emptyString
        phoneCountry = userDetails?.phoneCountry ?? Constants.Characters.emptyString
        customProperties = userDetails?.customProperties ?? [:]
        
        let keyValuePairs = (userDetails?.customProperties ?? [:]).map { "\($0.key): \($0.value)" }
        customPropertiesString = keyValuePairs.joined(separator: ", ")
    }
    
    var body: some View {
        FeatureBackgroundView(
            heading: Constants.Features.UserDetails.title,
            subheading: Constants.Features.UserDetails.subheading,
            mainButtonTitle: Constants.Features.UserDetails.mainButton,
            dismissTapped: {
                dismissAction()
            },
            mainButtonTapped: {
                updateButtonTapped()
            },
            content: {
                FeatureTextfield(title: Constants.Features.UserDetails.firstNameTitle,
                                 placeholder: Constants.Features.UserDetails.firstNamePlaceholer,
                                 content: $firstName)
                FeatureTextfield(title: Constants.Features.UserDetails.lastNameTitle,
                                 placeholder: Constants.Features.UserDetails.lastNamePlaceholer,
                                 content: $lastName)
                FeatureTextfield(title: Constants.Features.UserDetails.emailTitle,
                                 placeholder: Constants.Features.UserDetails.emailPlaceholer,
                                 content: $email)
                FeatureTextfield(title: Constants.Features.UserDetails.phoneCountryTitle,
                                 placeholder: Constants.Features.UserDetails.phoneCountryPlaceholer,
                                 content: $phoneCountry)
                FeatureTextfield(title: Constants.Features.UserDetails.phoneTitle,
                                 placeholder: Constants.Features.UserDetails.phonePlaceholer,
                                 content: $phone)
                FeatureTextfield(title: Constants.Features.UserDetails.customerPropertiesTitle,
                                 placeholder: Constants.Features.UserDetails.customerPropertyPlaceholer,
                                 description: Constants.Features.UserDetails.customerPropertyDescription,
                                 content: $customPropertiesString)
            })
    }

    private func dismissAction() {
        didDismiss(nil)
    }

    private func updateButtonTapped() {
        customProperties = SWUtilMethods.convertToDictionary(from: customPropertiesString)
        // Create UserDetails instance
        let userDetails = UserDetails(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            phoneCountry: phoneCountry,
            customProperties: customProperties
        )
        UserDefaults.standard.setUserDetails(userDetails)
        didDismiss(userDetails)
    }
}

struct UpdateUserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserDetailsView { _ in}
    }
}
