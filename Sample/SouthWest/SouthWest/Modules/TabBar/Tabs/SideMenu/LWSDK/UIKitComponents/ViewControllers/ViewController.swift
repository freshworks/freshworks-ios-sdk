//
//  ViewController.swift
//  FreshworksSDKTestApp
//
//  Created by Harish Kumar on 24/05/23.
//

import UIKit
import SwiftUI
import FreshworksSDK

final class ViewController: UIViewController {
    
    @IBOutlet weak var stackview: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFWObservers()
    }
    

    @IBAction func didTapShowConversations(_ sender: UIButton) {
        Freshworks.shared.showConversations(self)
    }
    
    @IBAction func didTapShowFAQs(_ sender: UIButton) {
        Freshworks.shared.showFAQs(self)
    }
    
    @IBAction func didTapConversationsAndFAQs(_ sender: UIButton) {
        let updateUserDetailsView = ConversationFaqsCategoryWithTags { (tags, filterType, showConversation)  in
            self.dismiss(animated: false) {
                if showConversation {
                    var faqTags = FAQTags()
                    faqTags.tags = tags
                    
                    switch  filterType {
                    case .conversation:
                        Freshworks.shared.showConversations(self, convTags: tags)
                        
                    case .category:
                        faqTags.filterType = .category
                        Freshworks.shared.showFAQs(self, faqTags: faqTags)
                        
                    case .article:
                        faqTags.filterType = .article
                        Freshworks.shared.showFAQs(self, faqTags: faqTags)
                        
                    case .none:
                        faqTags.filterType = .none
                        Freshworks.shared.showFAQs(self, faqTags: faqTags)
                    }
                }
            }
        }
        
        let hostingController = UIHostingController(rootView: updateUserDetailsView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
    @IBAction func didTapSetUser(_ sender: UIButton) {
        let updateUserDetailsView = UpdateUserDetailsView { (userDetails)  in
            self.dismiss(animated: false) {
                if let userDetails = userDetails {
                    Freshworks.shared.setUserDetails(firstName: userDetails.firstName ?? Constants.Characters.emptyString,
                                                     lastName: userDetails.lastName ?? Constants.Characters.emptyString,
                                                     email: userDetails.email ?? Constants.Characters.emptyString,
                                                     phone: userDetails.phone ?? Constants.Characters.emptyString,
                                                     phoneCountry: userDetails.phoneCountry ?? Constants.Characters.emptyString,
                                                     customProperties: userDetails.customProperties)
                }
            }
        }
        
        let hostingController = UIHostingController(rootView: updateUserDetailsView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
    @IBAction func didTapIdentifyUser(_ sender: UIButton) {
        let identifyUserView = IdentifyUserView { (externalId,restoreId, showConversation)  in
            self.dismiss(animated: false) {
                if showConversation {
                    Freshworks.shared.identifyUser(externalId: externalId, restoreId: restoreId)
                    Freshworks.shared.showConversations(self)
                }
            }
        }
        
        let hostingController = UIHostingController(rootView: identifyUserView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
    @IBAction func didTapResetUser(_ sender: UIButton) {
        resetUser()
    }
    
    @IBAction func didTapUpdateJWT(_ sender: Any) {
        
        let updateJWTView = UpdateJWTView { (jwt)  in
            self.dismiss(animated: false) {
                guard let jwt = jwt else { return }
                UserDefaults.standard.updateJWT(jwt)
                Freshworks.shared.updateUser(jwt)
            }
        }
        
        let hostingController = UIHostingController(rootView: updateJWTView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
    @IBAction func didTestTrackUserEvent(_ sender: UIButton) {
        let logUserEventView = LogUserEventView { (eventName, eventValue, isLogEvent)  in
            self.dismiss(animated: false) {
                if isLogEvent && !eventName.isEmpty {
                    Freshworks.shared.trackUserEvents(name: eventName, payload: eventValue)
                }
            }
        }
        
        let hostingController = UIHostingController(rootView: logUserEventView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
    @IBAction func changeWidgetLanguage(_ sender: UIButton) {
        showChangeLanguageView(.widget)
    }
    
    @IBAction func changeUserLanguage(_ sender: UIButton) {
        showChangeLanguageView(.user)
    }
    
    func showChangeLanguageView(_ type: ChangeLanguagueType) {
        let rawValue =  UserDefaults.standard.string(forKey: type.userDefaultKey) ?? SupportedLanguage.none.rawValue
        let userDefaultSelectedLangauge = SupportedLanguage(rawValue: rawValue) ?? .none
        
        let logUserEventView = ChangeLanguageView(changeLanguagueType: type,
                                                  selectedLangauge: userDefaultSelectedLangauge) { (selectedLanguage, isChangeLocale)  in
            self.dismiss(animated: false) {
                if isChangeLocale {
                    switch type {
                    case .user:
                        Freshworks.shared.changeUserLanguage(locale: selectedLanguage.localeCode)
                    case .widget:
                        Freshworks.shared.changeWidgetLanguage(locale: selectedLanguage.localeCode)
                    }
                }
            }
        }
        
        let hostingController = UIHostingController(rootView: logUserEventView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
    @IBAction private func showParallelConversationInputVC(_ sender: UIButton) {
        let parallelConversationsInputView = ParallelConversationsInputView { (conversationReferenceId,topicName, showConversation)  in
            self.dismiss(animated: false) {
                if showConversation {
                    Freshworks.shared.showConversation(conversationReferenceId: conversationReferenceId, topicName: topicName)
                }
            }
        }
        
        let hostingController = UIHostingController(rootView: parallelConversationsInputView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
    @IBAction private func changeAccount(_ sender: UIButton) {
        let changeAccountView = ChangeAccountView { [weak self] (sdkConfig)  in
            guard let self else { return }
            self.dismiss(animated: false) {
                if let sdkConfig = sdkConfig {
                    self.resetUser {
                        Freshworks.shared.initializeFreshworksSDK(with: sdkConfig)
                        UserDefaults.standard.updateSDKConfig(sdkConfig)
                    }
                }
            }
        }
        
        let hostingController = UIHostingController(rootView: changeAccountView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
    private func resetUser(completion: (() -> Void)? = nil) {
        UserDefaults.standard.resetUserDetails()
        Freshworks.shared.resetUser(completion: completion)
    }
}

extension ViewController {
    func addFWObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onUserCreated(_:)), name: Notification.Name(FRESHWORKS_USER_CREATED), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onRestoreIdReceived(_:)), name: Notification.Name(FRESHWORKS_USER_RESTORE_ID_GENERATED), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onUnreadCountChanged(_:)), name: Notification.Name(FRESHWORKS_UNREAD_MESSAGE_COUNT_CHANGED), object: nil)
    }
    
    func removeFWObservers() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(FRESHWORKS_USER_CREATED), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(FRESHWORKS_USER_RESTORE_ID_GENERATED), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(FRESHWORKS_UNREAD_MESSAGE_COUNT_CHANGED), object: nil)
    }
    
    @objc func onUserCreated(_ notification: NSNotification) {
        print(notification.name)
        print(notification.object ?? "")
        setUserDetails()
    }
    
    @objc func onRestoreIdReceived(_ notification: NSNotification) {
        print(notification.name)
        print(notification.object ?? "")
        if let retoreID = notification.object as? String {
            UserDefaults.standard.set(retoreID, forKey: Constants.UserDefaultsKeys.restoreID)
        }
    }
    
    @objc func onUnreadCountChanged(_ notification: NSNotification) {
        print(notification.name)
        print(notification.object as? Int as Any)
    }
    
}

extension ViewController {
    func setUserDetails() {
        if let userDetails = UserDefaults.standard.getUserDetails() {
            Freshworks.shared.setUserDetails(firstName: userDetails.firstName, lastName: userDetails.lastName, email: userDetails.email, phone: userDetails.phone, phoneCountry: userDetails.phoneCountry)

        }
    }
    
    func getUserDetails() {
        Freshworks.shared.getUser { user in
            print(user)
            
            var userDetails = UserDetails()
            userDetails.firstName = user.firstName
            userDetails.lastName = user.lastName
            userDetails.email = user.email
            userDetails.phone = user.phone
            userDetails.phoneCountry = user.phoneCountry
            userDetails.customProperties = user.meta
            
            UserDefaults.standard.setUserDetails(userDetails)
        }
    }
}
