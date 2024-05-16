//
//  ConfigureView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 13/02/24.
//

import SwiftUI

struct ConfigureView: View {
    
    @State private var outboundEventLogsEnabled: Bool
    @State private var dismissButtonEnabled: Bool
    let didDismiss: (_ outboundEventLogsEnabled: Bool, _ dismissButtonEnabled: Bool) -> Void
    
    init(outboundEventLogsEnabled: Bool, 
         dismissButtonEnabled: Bool,
         didDismiss: @escaping (Bool, Bool) -> Void) {
        _outboundEventLogsEnabled = State(initialValue: outboundEventLogsEnabled)
        _dismissButtonEnabled = State(initialValue: dismissButtonEnabled)
        self.didDismiss = didDismiss
    }
    
    var body: some View {
        FeatureBackgroundView(
            heading: Constants.Features.Configurations.title,
            subheading: Constants.Features.Configurations.subheading,
            mainButtonTitle: Constants.Features.Configurations.mainButton,
            dismissTapped: {
                dismiss()
            },
            mainButtonTapped: {
                dismiss()
            },
            content: {
                VStack (spacing: 16) {
                    Toggle(Constants.Features.Configurations.outboundEventsToggleTitle,
                           isOn: $outboundEventLogsEnabled)
                    Toggle(Constants.Features.Configurations.dismissButtonToggleTitle, 
                           isOn: $dismissButtonEnabled)
                }
            })
    }
    
    private func dismiss() {
        didDismiss(outboundEventLogsEnabled, dismissButtonEnabled)
    }
}

#Preview {
    ConfigureView(outboundEventLogsEnabled: false, dismissButtonEnabled: false) { _, _ in }
}
