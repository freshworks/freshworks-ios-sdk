//
//  FaqsCategoryWithTags.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 22/11/23.
//

import SwiftUI

enum FilterOptions: String, CaseIterable {
    case conversation = "Conversation"
    case category = "Category"
    case article = "Article"
}


struct ConversationFaqsCategoryWithTags: View {
    let didDismiss: (_ tags: [String], _ filterType: FilterOptions,  _ showConversation: Bool) -> Void
    
    @State private var tags: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.tags) ?? Constants.Characters.emptyString
    @State private var selectedOption: FilterOptions = FilterOptions(rawValue: UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.tagsSelectOption) ?? FilterOptions.conversation.rawValue) ?? .conversation
    
    
    var body: some View {
            
        FeatureBackgroundView(
            heading: Constants.Features.Tags.title,
            subheading: Constants.Features.Tags.subheading,
            mainButtonTitle: Constants.Features.Tags.mainButton,
            dismissTapped: {
                dismissAction()
            }, mainButtonTapped: {
                updateButtonTapped()
            }, content: {
                FeatureTextfield(
                    title: Constants.Features.Tags.tagsTitle,
                    placeholder: Constants.Features.Tags.tagsPlaceholder,
                    content: $tags
                )
                
                VStack(alignment: .leading) {
                    Text(Constants.Features.Tags.selectFilterType)
                        .font(.system(size: 13))

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(FilterOptions.allCases, id: \.self) { option in
                                FilterOptionView(option: option, isSelected: selectedOption == option) {
                                    selectedOption = option
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 10)
            })

    }
    
    private func dismissAction() {
        didDismiss([], .conversation, false)
    }
    
    private func updateButtonTapped() {
        UserDefaults.standard.set(tags, forKey: Constants.UserDefaultsKeys.tags)
        UserDefaults.standard.set(selectedOption.rawValue, forKey: Constants.UserDefaultsKeys.tagsSelectOption)
        didDismiss(tags.components(separatedBy: Constants.Characters.comma), selectedOption , true)
    }
}

struct FilterOptionView: View {
    let option: FilterOptions
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Text(option.rawValue)
            .accessibilityIdentifier(option.rawValue)
            .font(.system(size: 14))
            .padding(10)
            .frame(height: 32)
            .foregroundColor(isSelected ? .blue : .black.opacity(0.7))
            .background(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
            .cornerRadius(16)
            .onTapGesture {
                onTap()
            }
    }
}

struct FaqsCategoryWithTags_Previews: PreviewProvider {
    static var previews: some View {
        ConversationFaqsCategoryWithTags { _,_,_  in }
    }
}
