
Freshchat iOS SDK
=================

"Modern messaging software that your sales and customer engagement teams will love [FreshworksSDK](https://www.freshworks.com)."

## Installation
Freshchat iOS SDK can be integrated using cocoapods by specifying the following in your podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'

target 'Your project target' do
pod 'FreshworksSDK'
end
```

## Documentation
### Initialisation
In Appdelegate -> didFinishLaunchingWithOptions (Invoke the Freshworks initialisation)

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { 
    Freshworks.shared.initializeFreshworksSDK(with: SDKConfig(source: "JS-Path", appID: "AppID", appKey: "AppKey", domain: "Mobile-specific-domain"))
    registerNotifications() // For notification related, check PushNotification section at the last
    return true
}
```
`JS-Path` ==> Admin settings -> Web -> Web Widget -> Select a widget needed -> Click on Embed -> Under embed code use the `src` for JS-Path
`AppId, AppKey` ==> Admin settings -> Mobile SDK -> Under Appkeys
`Domain` ==> Admin settings -> Mobile App for Chat -> Unique Domain Id

### UserCreation and RestoreId 
- Listeners are required for `User Created` and `RestoreId` generated.
- Listener Names -> `FRESHCHAT_USER_CREATED` and `FRESHCHAT_USER_RESTORE_ID_GENERATED`
- Implementation
    ```swift
        NotificationCenter.default.addObserver(self, selector: #selector(self.onUserCreated(_:)), name: Notification.Name(FRESHCHAT_USER_CREATED), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onRestoreIdReceived(_:)), name: Notification.Name(FRESHCHAT_USER_RESTORE_ID_GENERATED), object: nil)
    ```
    ```swift
        @objc func onUserCreated(_ notification: NSNotification) {
            print("User created")
            print(notification.object ?? "")
        }
        @objc func onRestoreIdReceived(_ notification: NSNotification) {
            print("RestoreId Generated")
            print(notification.object ?? "")
        }
    ```

### User
- Inorder to Create/Update/SetUser use the below for reference. (customProperties -> Keys needs to be created in portal before its used). `This can be used only after the user is created`
    ```swift
         Freshworks.shared.setUserDetails(firstName: "UserFirstName", lastName: "UserLastName", email: "user@gmail.com", phone: "9876543210", phoneCountry: "+91", customProperties: ["cf_custom_field_name": "field value"])
    ```
- Set an Identifier for an User
    ```swift
        Freshworks.shared.identifyUser(externalId: "externalId")
    ```
- Restoring an existing User
    ```swift
        Freshworks.shared.identifyUser(externalId: "externalId", restoreId: "restoreId")
    ```
- To get current user information
    ```swift
        Freshworks.shared.getUser { [weak self] user in
            print(user)
        }
    ```
- Inorder to Reset an user
    ```swift
        Freshworks.shared.resetUser()
    ```

### Launch the support experiance
Note: self --> current viewcontroller
- Conversations
    ```swift
        Freshworks.shared.showConversations(self)
    ```
- Filter by Conversation tags
    ```swift
        Freshworks.shared.showConversations(self, convTags: ["Conversation tags applicable"])
    ```
- Faqs 
    ```swift
        Freshworks.shared.showFAQs(self)
    ```
- Filter by Faq tags
    ```swift
        Freshworks.shared.showFAQs(self, faqTags: FAQTags(tags: ["FaqTags applicable"], filterType: "FAQFilterType(category or article or none)"))
    ```

### PushNotifications
Request for notification permission if granted register the token with Freshworks.
```swift
   extension AppDelegate: UNUserNotificationCenterDelegate {
    func registerNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Handle authorization status
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Freshworks.shared.setPushRegistrationToken(deviceToken)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if Freshworks.shared.isFreshworksNotification(response) {
            Freshworks.shared.handleRemoteNotification(response) {
                completionHandler()
            }
        } else {
            completionHandler()
        }
    }
}      
```


## License
FreshchatSDK is released under the Commercial license. See [LICENSE](https://github.com/freshworks/freshworks-ios-sdk/blob/main/FreshworksSDK/LICENSE) for details.

## Support
[support@freshchat.com](mailto:support@freshchat.com)

[Support Portal](https://support.freshchat.com)

