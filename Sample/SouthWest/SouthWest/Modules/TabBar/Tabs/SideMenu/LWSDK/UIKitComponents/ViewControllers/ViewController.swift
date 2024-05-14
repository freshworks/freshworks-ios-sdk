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
    @IBOutlet weak var unreadCountBadgeLabel: UILabel!
    var outboundEventLogsEnabled = false
    var dismissButtonEnabled = false
    private var toastMessageQueue: [String] = []
    private var isToastShowing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFWObservers()
        setupUI()
    }
    
    private func setupUI() {
        unreadCountBadgeLabel.backgroundColor = .red
        unreadCountBadgeLabel.textColor = .white
        updateUnreadCount(Freshworks.shared.getUnreadCount())
    }
    
    // MARK: - Actions
    @IBAction func didTapShowConversations(_ sender: UIButton) {
        Freshworks.shared.showConversations(self)
        setDismissButton()
    }
    
    @IBAction func didTapShowFAQs(_ sender: UIButton) {
        Freshworks.shared.showFAQs(self)
        setDismissButton()
    }
    
    @IBAction func didTapConversationsAndFAQs(_ sender: UIButton) {
        let updateUserDetailsView = ConversationFaqsCategoryWithTags { [weak self] (tags, filterType, showConversation) in
            guard let `self` = self else { return }
            self.dismiss(animated: false) {
                if showConversation {
                    switch  filterType {
                    case .conversation:
                        Freshworks.shared.showConversations(self, convTags: tags)
                        
                    case .category:
                        let faqOptions = FAQOptions(tags: tags, filterType: .category)
                        Freshworks.shared.showFAQs(self, faqOptions: faqOptions)
                        
                    case .article:
                        let faqOptions = FAQOptions(tags: tags, filterType: .article)
                        Freshworks.shared.showFAQs(self, faqOptions: faqOptions)
                    
                    }
                    self.setDismissButton()
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
        let identifyUserView = IdentifyUserView { [weak self] (externalId,restoreId, showConversation)  in
            guard let `self` = self else { return }
            self.dismiss(animated: false) {
                if showConversation {
                    Freshworks.shared.identifyUser(externalId: externalId, restoreId: restoreId)
                    Freshworks.shared.showConversations(self)
                    self.setDismissButton()
                }
            }
        }

        let hostingController = UIHostingController(rootView: identifyUserView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
    @IBAction func didTapResetUser(_ sender: UIButton) {
        resetUser { [weak self] in
            self?.showToast(message: Constants.Toast.userResetSuccess)
        }
    }
    
    @IBAction func didSetConfigForLocalisation(_ sender: Any) {
        let setConfigLocalisationView = SetConfigLocalisationView { (headerProperty, content, toBeDismissed)  in
            self.dismiss(animated: false) {
                if !toBeDismissed {
                    typealias jsonDictionary = [String: Any]
                    var headerPropertyJSONData: jsonDictionary? = nil
                    var contentPropertyJSONData: jsonDictionary? = nil
                    
                    do{
                        if !headerProperty.isEmpty, let headerPropertyJson = headerProperty.data(using: String.Encoding.utf8) {
                            if let headerPropertyDecodedData = try JSONDecoder().decode(AnyCodable.self, from: headerPropertyJson).value as? [String: Any] {
                                headerPropertyJSONData = headerPropertyDecodedData
                            }
                        }
                        
                        if !content.isEmpty, let contentPropertyJson = content.data(using: String.Encoding.utf8) {
                            if let contentPropertyDecodedData = try JSONDecoder().decode(AnyCodable.self, from: contentPropertyJson).value as? [String: Any] {
                                contentPropertyJSONData = contentPropertyDecodedData
                            }
                        }
                    } catch {
                        print("Error with handling json: \(error.localizedDescription)")
                    }
                    
                    Freshworks.shared.updateConfig(headerProperty: headerPropertyJSONData, contentProperty: contentPropertyJSONData)
                }
            }
        }
        
        let hostingController = UIHostingController(rootView: setConfigLocalisationView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
    @IBAction func didTapUpdateJWT(_ sender: Any) {
        
        let updateJWTView = UpdateJWTView { [weak self] (jwt)  in
            self?.dismiss(animated: false) {
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
            self.dismiss(animated: false) { [weak self] in
                if isLogEvent && !eventName.isEmpty {
                    Freshworks.shared.trackUserEvents(name: eventName, payload: eventValue)
                    self?.showToast(message: Constants.Toast.eventSent + eventName)
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
        let parallelConversationsInputView = ParallelConversationsInputView { [weak self] (conversationReferenceId,topicName, showConversation) in
            guard let `self` = self else { return }
            self.dismiss(animated: false) {
                if showConversation {
                    Freshworks.shared.openConversation(self, conversationReferenceId: conversationReferenceId, topicName: topicName)
                    self.setDismissButton()
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
            guard let `self` = self else { return }
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
    
    @IBAction func updateCustomBotVariables(_ sender: Any) {
        let botVariablesViewData = PropertiesViewModelData(title: Constants.Features.UpdateCustomBotVariables.title, subheading: Constants.Features.UpdateCustomBotVariables.subheading, textEditor: Constants.Features.UpdateCustomBotVariables.textEditor, textEditorPlaceholder: Constants.Features.UpdateCustomBotVariables.textEditorPlaceholder, textEditorDescription: Constants.Features.UpdateCustomBotVariables.textEditorDescription)
        let botVariablesString = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.botVariables) ?? Constants.Characters.emptyString
        
        let updateCustomBotVariables = UpdateConvOrBotAttributesView(didDismiss: { [weak self] (botVariablesJsonString, isSetBotVariables)  in
            guard let `self` = self else { return }
            if SWUtilMethods.isValidJSON(botVariablesJsonString) {
                self.dismiss(animated: false) {
                    if isSetBotVariables {
                        Freshworks.shared.showConversations(self)
                        Freshworks.shared.setBotVariables(jsonString: botVariablesJsonString)
                        UserDefaults.standard.set(botVariablesJsonString, forKey: Constants.UserDefaultsKeys.botVariables)
                        self.setDismissButton()
                    }
                }
            } else {
                if isSetBotVariables {
                    self.showToast(message: Constants.Toast.invalidJson)
                } else {
                    self.dismiss(animated: false)
                }
            }
        }, attributesString: botVariablesString, propertiesViewAttributes: botVariablesViewData)
        let hostingController = UIHostingController(rootView: updateCustomBotVariables)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
 
    @IBAction func setCustomProperties(_ sender: Any) {
        let convPropertiesViewData = PropertiesViewModelData(title: Constants.Features.setConversationProperties.title, subheading: Constants.Features.setConversationProperties.subheading, textEditor: Constants.Features.setConversationProperties.textEditor, textEditorPlaceholder: Constants.Features.setConversationProperties.textEditorPlaceholder, textEditorDescription: Constants.Features.setConversationProperties.textEditorDescription)
        let convPropertiesString = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.conversationProperties) ?? Constants.Characters.emptyString
        
        let updateConversationProperties = UpdateConvOrBotAttributesView(didDismiss: { [weak self] (conversationPropertiesJsonString, isSetConvProperties)  in
            guard let `self` = self else { return }
            if SWUtilMethods.isValidJSON(conversationPropertiesJsonString) {
                self.dismiss(animated: false) {
                    if isSetConvProperties {
                        Freshworks.shared.showConversations(self)
                        Freshworks.shared.setConversationProperties(jsonString: conversationPropertiesJsonString)
                        UserDefaults.standard.set(conversationPropertiesJsonString, forKey: Constants.UserDefaultsKeys.conversationProperties)
                        self.setDismissButton()
                    }
                }
            } else {
                if isSetConvProperties {
                    self.showToast(message: Constants.Toast.invalidJson)
                } else {
                    self.dismiss(animated: false)
                }
            }
        }, attributesString: convPropertiesString, propertiesViewAttributes: convPropertiesViewData)
        let hostingController = UIHostingController(rootView: updateConversationProperties)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
    private func resetUser(completion: (() -> Void)? = nil) {
        UserDefaults.standard.resetUserDetails()
        Freshworks.shared.resetUser(completion: completion)
    }
    
    @IBAction func configureTapped(_ sender: UIButton) {
        let configureView = ConfigureView(
            outboundEventLogsEnabled: outboundEventLogsEnabled,
            dismissButtonEnabled: dismissButtonEnabled, didDismiss: { outboundEventLogsEnabled, dismissButtonEnabled in
                self.dismiss(animated: false) {
                    self.outboundEventLogsEnabled = outboundEventLogsEnabled
                    self.dismissButtonEnabled = dismissButtonEnabled
                }
            })
        let hostingController = UIHostingController(rootView: configureView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        present(hostingController, animated: false, completion: nil)
    }
    
}

extension ViewController {
    
    // MARK: - Notification observer methods
    
    func addFWObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onUserCreated(_:)), name: Notification.Name(FWEvents.userCreated.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onRestoreIdReceived(_:)), name: Notification.Name(FWEvents.restoreIdGenerated.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onUnreadCount(_:)), name: Notification.Name(FWEvents.unreadCount.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onFreshchatEventTriggered(_:)), name: Notification.Name(FWEvents.messageSent.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onFreshchatEventTriggered(_:)), name: Notification.Name(FWEvents.messageReceived.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onFreshchatEventTriggered(_:)), name: Notification.Name(FWEvents.csatUpdated.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onFreshchatEventTriggered(_:)), name: Notification.Name(FWEvents.csatReceived.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onFreshchatEventTriggered(_:)), name: Notification.Name(FWEvents.downloadFile.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onFreshchatEventTriggered(_:)), name: Notification.Name(FWEvents.userCleared.rawValue), object: nil)
    }
    
    func removeFWObservers() {
        for events in FWEvents.allCases {
            NotificationCenter.default.removeObserver(self, name: Notification.Name(events.rawValue), object: nil)
        }
    }
    
    @objc func onUserCreated(_ notification: NSNotification) {
        print(notification.name)
        print(notification.object ?? "")
        setUserDetails()
        self.showToastMessageForEvents(message: notification.name.rawValue)
    }
    
    @objc func onRestoreIdReceived(_ notification: NSNotification) {
        print(notification.name)
        print(notification.object ?? "")
        var eventInfo = notification.name.rawValue
        if let restoreID = notification.object as? String {
            UserDefaults.standard.set(restoreID, forKey: Constants.UserDefaultsKeys.restoreID)
            eventInfo += " : " + restoreID
        }
        self.showToastMessageForEvents(message: eventInfo)
    }
    
    @objc func onUnreadCount(_ notification: NSNotification) {
        print(notification.name)
        print(notification.object ?? "")
        var eventInfo = notification.name.rawValue
        if let unreadCount = notification.object as? Int {
            eventInfo += " : " + String(unreadCount)
            updateUnreadCount(unreadCount)
        }
        self.showToastMessageForEvents(message: eventInfo)
    }
    
    private func updateUnreadCount(_ count: Int) {
        let formattedCount = count > 9 ? "9+" : "\(count)"
        let hasUnreadCount = count > 0
        
        DispatchQueue.main.async {
            self.unreadCountBadgeLabel.text = hasUnreadCount ? formattedCount : Constants.Characters.emptyString
            self.unreadCountBadgeLabel.isHidden = !hasUnreadCount
            self.unreadCountBadgeLabel.layer.cornerRadius = self.unreadCountBadgeLabel.frame.height/2
            self.unreadCountBadgeLabel.clipsToBounds = true
            self.unreadCountBadgeLabel.layoutIfNeeded()
        }
    }
    
    @objc func onFreshchatEventTriggered(_ notification: NSNotification) {
        print(notification.name)
        print(notification.object ?? "")
        self.showToastMessageForEvents(message: notification.name.rawValue)
    }
    
}

extension ViewController {
    
    // MARK: - UserDefaults methods
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
    
    // MARK: - Dismiss button methods
    func setDismissButton() {
        if dismissButtonEnabled {
            DismissFreshworksButton.addToTopView()
        } else {
            DismissFreshworksButton.removeFromTopView()
        }
    }
    

    // MARK: -  Outbound events methods
    func showToastMessageForEvents(message: String) {
        if self.outboundEventLogsEnabled {
            self.showToast(message: message)
        }
    }

    func showToast(message: String, toBeAppended: Bool = true) {
        if toBeAppended {
            toastMessageQueue.append(message)
        }
        if !isToastShowing && !toastMessageQueue.isEmpty {
            isToastShowing = true
            let message = toastMessageQueue.first
            self.showToast(message: message, duration: 1.4) { [weak self] in
                self?.toastMessageQueue.removeFirst()
                self?.isToastShowing = false
                self?.showToast(message: "", toBeAppended: false)
            }
        }
    }
}

// MARK: - Dismiss button class
fileprivate class DismissFreshworksButton: UIButton {
    
    struct DismissFrame {
        static let positionX = UIScreen.main.bounds.width - Dimensions.DismissButton.height - Dimensions.DismissButton.trailingSpacing
        static let positionY = UIScreen.main.bounds.height - Dimensions.DismissButton.height - Dimensions.DismissButton.bottomSpacing
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    private func configureButton() {
        backgroundColor = UIColor(named: Colors.darkBlue)
        tintColor = .white
        setImage(UIImage(systemName: "xmark"), for: .normal)
        addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
    }
    
    static func addToTopView() {
        guard let topView = UIApplication.topView,
              let navigationController = topView as? UINavigationController,
              let topViewController = navigationController.viewControllers.first else {
            return
        }
        let dismissButton = DismissFreshworksButton()
        dismissButton.frame = CGRect(x: DismissFrame.positionX,
                                     y: DismissFrame.positionY,
                                     width: Dimensions.DismissButton.width,
                                     height: Dimensions.DismissButton.height)
        dismissButton.layer.cornerRadius = Dimensions.DismissButton.height / 2
        topViewController.view.addSubview(dismissButton)
        topViewController.view.bringSubviewToFront(dismissButton)
    }
    
    static func removeFromTopView() {
        guard let topView = UIApplication.topView,
              let navigationController = topView as? UINavigationController,
              let topViewController = navigationController.viewControllers.first else {
            return
        }
        topViewController.view.subviews.forEach {
            if $0 is DismissFreshworksButton { $0.removeFromSuperview() }
        }
    }
    
    @objc private func dismissTapped() {
        DismissFreshworksButton.removeFromTopView()
        Freshworks.shared.dismissFreshworksSDKViews()
    }
}
