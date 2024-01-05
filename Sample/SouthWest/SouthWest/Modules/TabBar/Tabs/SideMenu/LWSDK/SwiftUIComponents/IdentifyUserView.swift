//
//  IdentifyUserView.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 21/11/23.
//

import SwiftUI

struct IdentifyUserView: View {
    let didDismiss: (_ externalID: String, _ restoreID: String, _ showConversation: Bool) -> Void
    @State private var externalID: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.externalID) ?? Constants.Characters.emptyString
    @State private var restoreID: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.restoreID) ?? Constants.Characters.emptyString
    
    var body: some View {
        FeatureBackgroundView(
            heading: Constants.Features.IdentifyUser.title,
            subheading: Constants.Features.IdentifyUser.subheading,
            mainButtonTitle: Constants.Features.IdentifyUser.mainButton,
            dismissTapped: {
                dismissAction()
            },
            mainButtonTapped: {
                updateButtonTapped()
            },
            content: {
                FeatureTextfield(
                    title: Constants.Features.IdentifyUser.externaIDTitle,
                    placeholder: Constants.Features.IdentifyUser.externalIDPlaceholder,
                    content: $externalID
                )
                FeatureTextfield(
                    title: Constants.Features.IdentifyUser.restoreIDTitle,
                    placeholder: Constants.Features.IdentifyUser.restoreIDPlaceholder,
                    content: $restoreID
                )
            })
    }

    private func dismissAction() {
        didDismiss(Constants.Characters.emptyString, Constants.Characters.emptyString ,false)
    }

    private func updateButtonTapped() {
        UserDefaults.standard.set(externalID, forKey: Constants.UserDefaultsKeys.externalID)
        UserDefaults.standard.set(restoreID, forKey: Constants.UserDefaultsKeys.restoreID)
        didDismiss(externalID, restoreID , true)
    }
}

struct UpdateRestoreAndExternalIdView_Previews: PreviewProvider {
    static var previews: some View {
        IdentifyUserView { _,_,_  in }
    }
}

