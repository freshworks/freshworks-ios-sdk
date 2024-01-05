//
//  UpdateJWTView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 08/12/23.
//

import SwiftUI
import Combine
import FreshworksSDK

struct UpdateJWTView: View {
    
    let didDismiss: (_ jwt: String?) -> Void

    var handler = JWTObservableHandler()

    @State private var userState: String = Constants.Characters.emptyString
    @State private var uuid: String = Constants.Characters.emptyString
    @State private var jwt: String = Constants.Characters.emptyString
    
    @State private var showAlert: Bool = false
    
    @State private var cancellables: Set<AnyCancellable> = []

    var body: some View {
        FeatureBackgroundView(
            heading: Constants.Features.UpdateJWT.title,
            subheading: Constants.Features.UpdateJWT.subheading,
            mainButtonTitle: Constants.Features.UpdateJWT.mainButton,
            dismissTapped: {
                dismiss()
            }, mainButtonTapped: {
                authenticate()
            }, content: {
                FeatureTextfield(
                    title: Constants.Features.UpdateJWT.userStateTitle,
                    placeholder: Constants.Features.UpdateJWT.userStatePlaceholder,
                    content: $userState
                )
                FeatureTextfield(
                    title: Constants.Features.UpdateJWT.uuidTitle,
                    placeholder: Constants.Features.UpdateJWT.uuidPlaceholder,
                    content: $uuid
                )
                FeatureTextfield(
                    title: Constants.Features.UpdateJWT.tokenTitle,
                    placeholder: Constants.Features.UpdateJWT.tokenPlaceholder,
                    content: $jwt
                )
                    .padding(.bottom, 20)
            }
        )
        .onAppear {
            handler.setDelegate()
            
            // Observe changes in the state property
            handler.$state.sink { newUserState in
                handleUserStateChanged(newUserState)
            }
            .store(in: &cancellables)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(Constants.Alert.title),
                message: Text(Constants.Features.UpdateJWT.alertMessage),
                dismissButton: .default(Text(Constants.Alert.okay))
            )
        }
    }
    
    private func handleUserStateChanged(_ userState: UserState) {
        self.userState = userState.rawValue
        switch userState {
        case .authenticated, .created, .loaded, .identified, .restored: break
        case .unloaded, .notLoaded, .notCreated, .notAuthenticated: fetchUUID()
        }
    }
    
    private func fetchUUID() {
        Freshworks.shared.getUUID { uuid in
            self.uuid = uuid
        }
    }
    
    private func dismiss() {
        didDismiss(nil)
    }
    
    private func authenticate() {
        guard !jwt.isEmpty else {
            showAlert = true
            return
        }
        showAlert = false
        didDismiss(jwt)
    }

}

struct UpdateJWTView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateJWTView { _ in }
    }
}

class JWTObservableHandler: ObservableObject, FreshworksJWTDelegate {
    
    @Published var state: UserState = .notLoaded
    
    func setDelegate() {
        Freshworks.shared.setJWTDelegate(self)
    }
    
    func userStateChanged(_ userState: UserState) {
        DispatchQueue.main.async {
            self.state = userState
        }
    }
}
