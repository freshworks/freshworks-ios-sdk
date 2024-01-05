Freshworks iOS SDK
=================

"Modern messaging software that your sales and customer engagement teams will love [FreshworksSDK](https://www.freshworks.com)."

## Installation
Freshworks iOS SDK can be integrated using cocoapods by specifying the following in your podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '14.0'

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
- Listener Names -> `FRESHWORKS_USER_CREATED` and `FRESHWORKS_USER_RESTORE_ID_GENERATED`
- Implementation
    ```swift
        NotificationCenter.default.addObserver(self, selector: #selector(self.onUserCreated(_:)), name: Notification.Name(FRESHWORKS_USER_CREATED), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onRestoreIdReceived(_:)), name: Notification.Name(FRESHWORKS_USER_RESTORE_ID_GENERATED), object: nil)
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
    Note: For JWT enabled accounts, updating the user properties will be done through the JWT payload. Please refer the 'JWT' section below.

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

### Launch the support experience
Note: self --> current viewcontroller
- Conversations
    ```swift
        Freshworks.shared.showConversations(self)
    ```
- Faqs 
    ```swift
        Freshworks.shared.showFAQs(self)
    ```
- Filter by Conversation tags
  
    Customize your conversation by adding tags to Conversation during creation. Tags help filter and display specific conversation on freshworksDK.
    To implement, pass tags during showConversations public api call for relevant conversation.
    ```swift
        Freshworks.shared.showConversations(self, convTags: ["Conversation tags applicable"])
    ```
- Filter by Faq tags
  
    Customize your FAQs by adding tags during creation. Tags assist in filtering and displaying specific FAQs on FreshworksSDK.
    To implement, include faqTags in the showFAQs public API call. Use filterType (category, article, or none) based on your specific requirement.

    ```swift
        Freshworks.shared.showFAQs(self, faqTags: FAQTags(tags: ["FaqTags applicable"], filterType: "FAQFilterType(category or article or none)"))
    ```
- Parallel conversations

     In Freshchat, enable parallel conversation on the same topic. While multiple topics are supported, initiating parallel conversations on a single topic was challenging. For instance, in an e-commerce setting, managing Payment Support for various       transactions was cumbersome. Our solution, Parallel conversation, allows multiple conversation threads on a single topic. To implement this, provide a unique conversationReferenceId with the FreshworksSDK. Customers can use the API 
     showConversation. Support representatives guide users in configuring unique conversationReferenceIds, enabling seamless topic-specific conversations.

    ```swift
        Freshworks.shared.showConversation(conversationReferenceId: "<conv ref id>", topicName: "<topicName>")
        Freshworks.shared.showConversation(conversationReferenceId: "1", topicName: "Test Topic")
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

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if Freshworks.shared.isFreshworksNotification(userInfo) {
            Freshworks.shared.handleRemoteNotification(userInfo) {
                completionHandler( [.banner, .badge, .sound])
            }
        } else {
            completionHandler( [.banner, .badge, .sound])
        }
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
### Multi-Language Support (Locale Change)
FreshworksSDK provides multilanguage support. The list of all supported languages and their keys are provided in the table below.

| LANGUAGE CODE | LANGUAGE                        |
| ------------- | ------------------------------- |
| ar            | Arabic Language (RTL)          |
| en            | English                         |
| ca            | Catalan                         |
| zh-HANS       | Chinese (Simplified)           |
| zh-HANT       | Chinese (Traditional)          |
| cs            | Czech                           |
| da            | Danish                          |
| nl            | Dutch                           |
| de            | German                          |
| et            | Estonian                        |
| fi            | Finnish                         |
| fr            | French                          |
| hu            | Hungarian                       |
| id            | Indonesian                      |
| it            | Italian                         |
| ko            | Korean                          |
| lv            | Latvian                         |
| nb            | Norwegian                       |
| pl            | Polish                          |
| pt            | Portuguese                      |
| pt-BR         | Portuguese - Brazil             |
| ro            | Romanian                        |
| ru            | Russian                         |
| sk            | Slovak                          |
| sl            | Slovenian                       |
| es            | Spanish                         |
| es-LA         | Spanish - Latin America         |
| sv            | Swedish                         |
| th            | Thai                            |
| tr            | Turkish                         |
| uk            | Ukrainian                       |
| vi            | Vietnamese                      |


- Widget locale change

    The language is selected based on priority and is explained below.
    1. Configured Language:
    The highest priority is given to the language that is specified when the freshworksSDK is initialized or changeWidgetLanguage public api is called.
    For instance, in the below code the key locale is used to set the language when the freshworksSDK is initalized or changeWidgetLanguage public api is called.

   ```swift
        Freshworks.shared.initializeFreshworksSDK(with: SDKConfig(source: "JS-Path", appID: "AppID", appKey: "AppKey", domain: "Mobile-specific-domain", locale: "en"))
        or use below after initialization
        Freshworks.shared.changeWidgetLanguage(locale: "ar")
   ```

    2. Default Language:
      The lowest priority is the Default Language which is set in your Freshchat account. This will be the primary language that is specified on your Freshchat Account.
        
- User locale change

  If you want the Freshchat widget's language to be changed dynamically based on user selection such as language dropdown, the locale has to be set when the dropdown is changed.
  You will have to use the below code to specify the language in that case. Please refer to the sample code below for better clarity.
    
    ```swift
        Freshworks.shared.changeUserLanguage(locale: "en")
    ```
### Tracking User Events
- Freshchat allows you to track any events performed by your users. It can be anything, ranging from updating their profile picture to adding 5 items to the cart. You can use these events as context while engaging with the user. Events can also be used to set up triggered messages or to segment users for campaigns.
    ```swift
        Freshworks.shared.trackUserEvents(name: "eventName", payload: ["eventName":"eventValue"])
    ```
### JWT Authentication
- Enabling user authentication using JSON Web Token:
  
Freshchat uses JSON Web Token (JWT) to allow only authenticated users to initiate a conversation with you through the Freshchat messenger. Freshchat sends a callback (along with the user’s authentication status) to let you know about any event with respect to the messenger and user’s authentication status.

Step 1: Create the JWT without UUID using the public & private keys.

Step 2: Initiate the SDK with the above JWT.

```swift
Freshworks.shared.initializeFreshworksSDK(with: SDKConfig(
    source: "JS-Path", appID: "AppID", appKey: "AppKey", domain: "Mobile-specific-domain", jwtAuthToken: "jwt-token-without-uuid"
))
```

Note: If your account is JWT enabled, it is mandatory to pass JWT while SDK initialization.

Step 3: Set 'YourClass' as the delegate to receive user state change updates.
```swift
Freshworks.shared.setJWTDelegate(self) // 'self' is the instance of <YourClass>'
```

Step 4: Implement the 'FreshworksJWTDelegate' function to receive the user state change updates. Once user state change update is received, if the user is not authenticated, fetch the UUID from 'Freshworks.shared.getUUID { uuid in }'
```swift
extension <YourClass>: FreshworksJWTDelegate {

  func userStateChanged(_ userState: UserState) {
  
    switch userState {
    
    case .authenticated, .created, .loaded, .identified, .restored: 
        break
        
    case .unloaded, .notLoaded, .notCreated, .notAuthenticated: 
        fetchUUID()
        
    @unknown default: 
        break
    }
  }

  func fetchUUID() {
    Freshworks.shared.getUUID { [weak self] uuid in
      // Use this uuid to generate a valid JWT
    }
  }
}
```

Step 5: Create a valid JWT using the UUID recevied from step 4 and update the same.
```swift
Freshworks.shared.updateUser("<valid-JWT>")
```
Note: The above API (Freshworks.shared.updateUser) will also be responsible for updating the user details. While creating the JWT, the details which need to be updated should be added in the payload.

### Beta Readme Note
**Issue:**
User properties are not getting updated if the SDK is not initialized.

**Solution:**
To successfully update user details, make sure the SDK is properly initialized. If user details retrieval fails, it is likely because the SDK has not been initialized. Ensure initialization before attempting to update user information. We appreciate your understanding and patience as we work towards enhancing your experience.


## License
FreshworksSDK is released under the Commercial license. See [LICENSE](https://github.com/freshworks/freshworks-ios-sdk/blob/main/FreshworksSDK/LICENSE) for details.

## Support
[support@freshchat.com](mailto:support@freshchat.com)

[Support Portal](https://support.freshchat.com)
