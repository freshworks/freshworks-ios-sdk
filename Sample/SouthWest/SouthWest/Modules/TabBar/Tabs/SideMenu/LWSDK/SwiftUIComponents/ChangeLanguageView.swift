//
//  ChangeLanguageView.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 12/12/23.
//

import SwiftUI

struct ChangeLanguageView: View {
    let changeLanguagueType: ChangeLanguagueType
    @State var selectedLangauge: SupportedLanguage
    let didDismiss: ( _ locale: SupportedLanguage, _ changeLocale: Bool) -> Void
    
    var body: some View {
        FeatureBackgroundView(
            heading: changeLanguagueType.title,
            subheading: Constants.Features.ChangeLanguage.subheading,
            mainButtonTitle: Constants.Features.ChangeLanguage.mainButton,
            dismissTapped: {
                dismissAction()
            },
            mainButtonTapped: {
                updateButtonTapped()
            },
            content: {
                Picker(Constants.Features.ChangeLanguage.pickerTitle, selection: $selectedLangauge) {
                    ForEach(SupportedLanguage.getLanguages(for: changeLanguagueType)) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(.wheel)
            })
    }

    private func dismissAction() {
        didDismiss(.none ,false)
    }

    private func updateButtonTapped() {
        UserDefaults.standard.set(selectedLangauge.rawValue, forKey: changeLanguagueType.userDefaultKey)
        didDismiss(selectedLangauge, true)
    }
}

struct ChangeLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLanguageView(changeLanguagueType: .user, selectedLangauge: .english) { _,_  in }
    }
}


