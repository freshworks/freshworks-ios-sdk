//
//  SupportedLanguage.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 12/12/23.
//

import Foundation

enum SupportedLanguage: String, CaseIterable, Identifiable {
    case none = "None"
    case arabic_language_rtl = "Arabic Language (RTL)"
    case english = "English"
    case catalan = "Catalan"
    case chinese_simplified = "Chinese (Simplified)"
    case chinese_traditional = "Chinese (Traditional)"
    case czech = "Czech"
    case danish = "Danish"
    case dutch = "Dutch"
    case german = "German"
    case estonian = "Estonian"
    case finnish = "Finnish"
    case french = "French"
    case hungarian = "Hungarian"
    case indonesian = "Indonesian"
    case italian = "Italian"
    case korean = "Korean"
    case latvian = "Latvian"
    case norwegian = "Norwegian"
    case polish = "Polish"
    case portuguese = "Portuguese"
    case portuguese_brazil = "Portuguese - Brazil"
    case romanian = "Romanian"
    case russian = "Russian"
    case slovak = "Slovak"
    case slovenian = "Slovenian"
    case spanish = "Spanish"
    case spanish_latin_america = "Spanish - Latin America"
    case swedish = "Swedish"
    case thai = "Thai"
    case turkish = "Turkish"
    case ukrainian = "Ukrainian"
    case vietnamese = "Vietnamese"

    var localeCode: String {
        switch self {
        case .none: return ""
        case .arabic_language_rtl: return "ar"
        case .english: return "en"
        case .catalan: return "ca"
        case .chinese_simplified: return "zh-HANS"
        case .chinese_traditional: return "zh-HANT"
        case .czech: return "cs"
        case .danish: return "da"
        case .dutch: return "nl"
        case .german: return "de"
        case .estonian: return "et"
        case .finnish: return "fi"
        case .french: return "fr"
        case .hungarian: return "hu"
        case .indonesian: return "id"
        case .italian: return "it"
        case .korean: return "ko"
        case .latvian: return "lv"
        case .norwegian: return "nb"
        case .polish: return "pl"
        case .portuguese: return "pt"
        case .portuguese_brazil: return "pt-BR"
        case .romanian: return "ro"
        case .russian: return "ru"
        case .slovak: return "sk"
        case .slovenian: return "sl"
        case .spanish: return "es"
        case .spanish_latin_america: return "es-LA"
        case .swedish: return "sv"
        case .thai: return "th"
        case .turkish: return "tr"
        case .ukrainian: return "uk"
        case .vietnamese: return "vi"
        }
    }
    
    var id: SupportedLanguage { self }
    static func getLanguages(for changeLanguagueType: ChangeLanguagueType) -> [SupportedLanguage] {
        switch changeLanguagueType {
        case .widget:
            return SupportedLanguage.allCases
        case .user:
            var languages = SupportedLanguage.allCases
            languages.removeAll { $0 == .none}
            return languages
        }
    }
}

enum ChangeLanguagueType {
    case widget
    case user
    
    var title: String {
        switch self {
        case .widget:
            return Constants.Features.ChangeLanguage.widgetLanguage
        case .user:
            return Constants.Features.ChangeLanguage.userLanguage
        }
    }
    
    var userDefaultKey: String {
        switch self {
        case .widget:
            return Constants.UserDefaultsKeys.selectedWidgetLanguageLocaleCode
        case .user:
            return Constants.UserDefaultsKeys.selectedUserLanguageLocaleCode
        }
    }
    
}
