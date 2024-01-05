//
//  ParallelConversationsInputView.swift
//  FreshworksSDKTestApp
//
//  Created by Shahebaz Shaikh on 21/08/23.
//

import SwiftUI

struct ParallelConversationsInputView: View {
    let didDismiss: (_ conversationReferenceId: String, _ topicName: String, _ showConversation: Bool) -> Void

    @State private var conversationReferenceId: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.conversationReferenceId) ?? Constants.Characters.emptyString
    @State private var topicName: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.topicNameForConversationReferenceId) ?? Constants.Characters.emptyString

    var body: some View {
        FeatureBackgroundView(
            heading: Constants.Features.ParallelConversation.title,
            subheading: Constants.Features.ParallelConversation.subheading,
            mainButtonTitle: Constants.Features.ParallelConversation.mainButton,
            dismissTapped: {
                dismissAction()
            },
            mainButtonTapped: {
                updateButtonTapped()
            },
            content: {
                FeatureTextfield(
                    title: Constants.Features.ParallelConversation.referenceIdTitle,
                    placeholder: Constants.Features.ParallelConversation.referenceIdPlaceholder,
                    content: $conversationReferenceId
                )
                FeatureTextfield(
                    title: Constants.Features.ParallelConversation.topicNameTitle,
                    placeholder: Constants.Features.ParallelConversation.topicNamePlaceholder,
                    content: $topicName
                )
            })
    }

    private func dismissAction() {
        didDismiss(Constants.Characters.emptyString, Constants.Characters.emptyString ,false)
    }

    private func updateButtonTapped() {
        UserDefaults.standard.set(conversationReferenceId, forKey: Constants.UserDefaultsKeys.conversationReferenceId)
        UserDefaults.standard.set(topicName, forKey: Constants.UserDefaultsKeys.topicNameForConversationReferenceId)
        didDismiss(conversationReferenceId, topicName , true)
    }
}

struct ParallelConversationsInputView_Previews: PreviewProvider {
    static var previews: some View {
        ParallelConversationsInputView { _,_,_  in }
    }
}
