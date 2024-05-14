//
//  PropertiesViewData.swift
//  SouthWest
//
//  Created by Ravipati Lakshmi Sai Chandana on 23/01/24.
//

import Foundation

struct PropertiesViewModelData {
    var title: String = Constants.Characters.emptyString
    var subheading: String = Constants.Characters.emptyString
    var textEditor: String = Constants.Characters.emptyString
    var textEditorPlaceholder: String = Constants.Characters.emptyString
    var textEditorDescription: String = Constants.Characters.emptyString
    
    init(title: String, subheading: String = "", textEditor: String, textEditorPlaceholder: String, textEditorDescription: String = "") {
        self.title = title
        self.subheading = subheading
        self.textEditor = textEditor
        self.textEditorDescription = textEditorDescription
        self.textEditorPlaceholder = textEditorPlaceholder
    }
}
