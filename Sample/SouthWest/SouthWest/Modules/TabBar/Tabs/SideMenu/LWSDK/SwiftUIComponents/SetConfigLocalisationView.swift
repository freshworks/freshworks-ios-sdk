//
//  SetConfigLocalisationView.swift
//  SouthWest
//
//  Created by Srivikashini Venkatachalam on 29/01/24.
//

import SwiftUI

struct SetConfigLocalisationView: View {
    let didDismiss: (_ headerProperty: String, _ contentProperty: String, _ toBeDismissed: Bool) -> Void
        @State private var headerProperty: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.headerProperty) ?? Constants.Characters.emptyString
        @State private var contentProperty: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.contentProperty) ?? Constants.Characters.emptyString
        
        var body: some View {
            FeatureBackgroundView(
                heading: Constants.Features.LocalisationConfig.title,
                subheading: Constants.Features.LocalisationConfig.subheading,
                mainButtonTitle: Constants.Features.LocalisationConfig.mainButton,
                dismissTapped: {
                    dismissAction()
                },
                mainButtonTapped: {
                    updateButtonTapped()
                },
                content: {
                    FeatureTextEditor(
                        title: Constants.Features.LocalisationConfig.headerPropertyTitle,
                        placeholder: Constants.Features.LocalisationConfig.headerPropertyPlaceholder,
                        description: Constants.Features.LocalisationConfig.headerPropertyDescription,
                        content: $headerProperty
                    )
                    
                    FeatureTextEditor(
                        title: Constants.Features.LocalisationConfig.contentPropertyTitle,
                        placeholder: Constants.Features.LocalisationConfig.contentPropertyPlaceholder,
                        description: Constants.Features.LocalisationConfig.contentPropertyDescription,
                        content: $contentProperty
                    )
                })
        }
        private func dismissAction() {
            didDismiss(Constants.Characters.emptyString, Constants.Characters.emptyString, true)
        }
        private func updateButtonTapped() {
            UserDefaults.standard.set(headerProperty, forKey: Constants.UserDefaultsKeys.headerProperty)
            UserDefaults.standard.set(contentProperty, forKey: Constants.UserDefaultsKeys.contentProperty)
            didDismiss(headerProperty, contentProperty, false)
        }
}

struct SetConfigLocalisationView_Previews: PreviewProvider {
    static var previews: some View {
        SetConfigLocalisationView { _,_,_   in }
    }
}
