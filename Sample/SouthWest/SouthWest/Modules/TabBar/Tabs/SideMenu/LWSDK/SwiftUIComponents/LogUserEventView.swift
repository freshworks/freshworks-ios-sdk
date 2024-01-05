//
//  LogUserEventView.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 08/12/23.
//

import SwiftUI

struct LogUserEventView: View {
    let didDismiss: (_ eventName: String, _ eventValue: [String: String], _ isLogEvent: Bool) -> Void
    @State private var eventName: String = Constants.Characters.emptyString
    @State private var eventValue: String = Constants.Characters.emptyString
    
    
    
    var body: some View {
        FeatureBackgroundView(
            heading: Constants.Features.LogEvent.title,
            subheading: Constants.Features.LogEvent.subheading,
            mainButtonTitle: Constants.Features.LogEvent.mainButton,
            dismissTapped: {
                dismissAction()
            },
            mainButtonTapped: {
                didDismiss(eventName, convertToDictionary() , true)
            },
            content: {
                FeatureTextfield(
                    title: Constants.Features.LogEvent.eventNameTitle,
                    placeholder: Constants.Features.LogEvent.eventNamePlaceholder,
                    content: $eventName
                )
                FeatureTextfield(
                    title: Constants.Features.LogEvent.eventValueTitle,
                    placeholder: Constants.Features.LogEvent.eventValuePlaceholder,
                    description: Constants.Features.LogEvent.eventValueDescription,
                    content: $eventValue
                )
            })
    }
    
    private func convertToDictionary() -> [String: String] {
        let eventValueProperties = eventValue
            .replacingOccurrences(of: Constants.Characters.singleSpace, with: Constants.Characters.emptyString)
            .replacingOccurrences(of: Constants.Characters.backslashWithDoubleQuote, with: Constants.Characters.emptyString)
            .components(separatedBy: Constants.Characters.comma)
            .reduce(into: [String: String]()) { result, keyValue in
                let components = keyValue.components(separatedBy: Constants.Characters.colon)
                if components.count == 2 {
                    let key = components[0]
                    let value = components[1]
                    result[key] = value
                }
            }
        
        return eventValueProperties
    }

    private func dismissAction() {
        didDismiss(Constants.Characters.emptyString, [:] ,false)
    }
}

struct LogUserEventView_Previews: PreviewProvider {
    static var previews: some View {
        LogUserEventView { _,_,_  in }
    }
}

