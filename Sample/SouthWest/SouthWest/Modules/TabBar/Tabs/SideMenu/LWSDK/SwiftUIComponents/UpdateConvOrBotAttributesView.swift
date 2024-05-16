//
//  UpdateConvOrBotAttributesView.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 19/12/23.
//

import SwiftUI

struct UpdateConvOrBotAttributesView: View {
    let didDismiss: (_ attributesString: String, _ isSetAttributes: Bool) -> Void
    @State var attributesString: String
    let propertiesViewAttributes: PropertiesViewModelData
    
    var body: some View {
        FeatureBackgroundView(
            heading: propertiesViewAttributes.title,
            subheading: propertiesViewAttributes.subheading,
            mainButtonTitle: Constants.Features.UpdateConvOrBotAttributesView.mainButton,
            dismissTapped: {
                dismissAction()
            },
            mainButtonTapped: {
                updateButtonTapped()
            },
            content: {
                FeatureTextEditor(
                    title: propertiesViewAttributes.textEditor,
                    placeholder: propertiesViewAttributes.textEditorPlaceholder,
                    description: propertiesViewAttributes.textEditorDescription,
                    content: $attributesString
                )
            })
    }
    
    private func updateButtonTapped() {
        didDismiss(attributesString , true)
    }
    
    private func dismissAction() {
        didDismiss(Constants.Characters.emptyString ,false)
    }
}

struct UpdateConvOrBotAttributesView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateConvOrBotAttributesView(didDismiss: { _,_ in }, attributesString: "", propertiesViewAttributes: PropertiesViewModelData(title: "", subheading: "", textEditor: "", textEditorPlaceholder: "", textEditorDescription: ""))
    }
}

