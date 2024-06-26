//
//  SWConstants.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 21/11/23.
//

import Foundation

typealias CallbackWithInt = (Int) -> ()
typealias Callback = () -> ()

struct Constants {
    
    struct Characters {
        static let emptyString = ""
        static let singleSpace = " "
        static let backslashWithDoubleQuote = "\""
        static let comma = ","
        static let colon = ":"
        static let commaSpace = ", "
        static let colonSpace = ": "
    }

    struct Alert {
        static let title = "Alert"
        static let okay = "Okay"
    }
    
    struct Toast {
        static let eventSent = "Event sent: "
        static let userResetSuccess = "User reset was successful"
        static let invalidJson = "Invalid JSON. Please enter the correct JSON."
    }
    
    struct Login {
        static let sampleEmail = "test@gmail.com"
        static let samplePassword = "123456"
        static let email = "Email"
        static let password = "Password"
        static let forgotPassword = "Forgot Password?"
        static let signIn = "Sign In"
        static let or = "or"
        static let noAccount = "Don't have an account?"
        static let register = "Register Now"
        static let credentialsAlertTitle = "Invalid Credentials"
        static let credentialsAlertMessage = "Please enter a valid email and password."
        static let credentialsAlertButton = "Okay"
        static let emailPredicate = "SELF MATCHES %@"
        static let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        static let titleSignIn = "Let's Sign In"
        static let subheadingWelcome = "Welcome back, we missed you!"
    }
    
    struct Products {
        static let navigationTitleWelcome = "Welcome Back!"
        static let navigationSubtitleUsername = "Username"
        static let addToCart = "ADD TO CART"
    }
    
    struct Favourites {
        static let noFavourites = "No favourites added yet!"
    }
    
    struct Cart {
        static let checkout = "Checkout"
        static let cart = "Cart"
        static let done = "Done"
        static let continueButton = "Continue"
        static let returningCustomer = "Returning Customer"
        static let fasterCheckout = "Hey, welcome back! Sign in for faster checkout!"
        static let guest = "Guest"
        static let loginNotNeeded = "Login information not needed"
    }

    struct SideMenu {
        static let userName = "Falcon"
        static let userEmail = "falcon-email"
        static let myOrders = "My Orders"
        static let myOrdersDescription = "Already have 2 orders"
        static let sampleUnreadCount = "3"
        static let shippingAddresses = "Shipping Addresses"
        static let shippingAddressesDescription = "3 addresses"
        static let paymentMethod = "Payment Method"
        static let paymentMethodDescription = "VISA **34"
        static let readMore = "Read More"
        static let readMoreDescription = "FAQs"
        static let contactUs = "Contact Us"
        static let contactUsDescription = "Talk to an agent"
        static let myReview = "My Reviews"
        static let myReviewDescription = "Reviews for 4 items"
        static let settings = "Developer Settings"
        static let settingsDescription = "To develop and test"
        static let logout = "Logout"
        static let unreadNotificationName = "FRESHCHAT_UNREAD_MESSAGE_COUNT_CHANGED"
        static let SDKVersionTitle = "SDK Version: "
    }

    struct Features {
        
        struct UserDetails {
            static let title = "Update User"
            static let subheading = ""
            static let mainButton = "Update"
            
            static let firstNameTitle = "First Name"
            static let firstNamePlaceholer = "Enter first name"
            
            static let lastNameTitle = "Last Name"
            static let lastNamePlaceholer = "Enter last name"
            
            static let emailTitle = "Email"
            static let emailPlaceholer = "Enter email"
            
            static let phoneTitle = "Phone Number"
            static let phonePlaceholer = "Enter Phone Number"
            
            static let phoneCountryTitle = "Phone Country"
            static let phoneCountryPlaceholer = "Enter phone country"
            
            static let customerPropertiesTitle = "Custom Properties"
            static let customerPropertyPlaceholer = "Enter properties"
            
            static let customerPropertyDescription = "Please enter the properties in the below fomrat. Eg:Key1: value1, key2: value2"

        }
        
        struct IdentifyUser {
            static let title = "Identify User"
            static let subheading = ""
            static let mainButton = "Identify/Show"

            static let externaIDTitle = "External ID"
            static let externalIDPlaceholder = "Enter External ID here."

            static let restoreIDTitle = "Restore ID"
            static let restoreIDPlaceholder = "Enter Restore ID here."

        }
        
        struct LocalisationConfig {
            
            static let title = "Set localisation config"
            static let subheading = ""
            static let mainButton = "Update config data"
            
            static let headerPropertyTitle = "Header property"
            static let headerPropertyPlaceholder = "Enter header property Json here"
            static let headerPropertyDescription = """
                {
                 Please enter the header property value in the below format:
                
                   "appName": "Freshworks sample app",
                   "appLogo": "https://d1qb2nb5cznatu.cloudfront.net/startups/i/2473-2c38490d8e4c91660d86ff54ba5391ea-medium_jpg.jpg"
                }
                """

            static let contentPropertyTitle = "Content property"
            static let contentPropertyPlaceholder = "Enter content property Json here"
            static let contentPropertyDescription = """
               {
                Please enter the content property value in the below format:
               
                   "welcomeMessage": "Hello Welcome",
                   "headers": {
                       "faq": "Faqs-Sections",
                       "chat": "Chat with us - Say Hi",
                       "csat_question": "Did we address your queries??"
                   },
                   "placeholders": {
                       "search_field": "Search here"
                   }
               }
               """
        }
        
        struct ParallelConversation {
            static let title = "Open Conversation"
            static let subheading = ""
            static let mainButton = "Open"

            static let topicNameTitle = "Topic Name"
            static let topicNamePlaceholder = "Enter Topic name here."
            
            static let referenceIdTitle = "Conversation Reference ID"
            static let referenceIdPlaceholder = "Enter ConversationReferenceId here."
        }
        
        struct LoadAccount {
            static let title = "Load Account"
            static let subheading = "Enter your account credentials to initialise the SDK"
            static let mainButton = "Update"
            
            static let widgetSourceTitle = "Widget Source"
            static let widgetSourcePlaceholder = "Enter Source"
            
            static let appIdTitle = "App ID"
            static let appIdPlaceholder = "Enter app ID"
            
            static let appKeyTitle = "App Key"
            static let appKeyPlaceholder = "Enter app key"
            
            static let domainTitle = "Domain"
            static let domainPlaceholder = "Enter domain"
            
            static let widgetIdTitle = "Widget ID"
            static let widgetIdPlaceholder = "Enter widget ID"
            
            static let authTokenTitle = "Auth Token"
            static let authTokenPlaceholder = "Enter auth token"
            
            static let footer = "Auth token is mandatory only for JWT enabled acoounts"
            
            static let alertMessage = "Source, App ID, App key & domain are mandatory feilds."
        }
        
        struct Tags {
            static let title = "Conversation & FAQs Tags"
            static let subheading = "Enter the tags in a format where they are separated by a comma and a space, for example: Tag1,Tag2"
            static let mainButton = "Show"
            
            static let tagsTitle = "Tags"
            static let tagsPlaceholder = "Add Tags"
            
            static let selectFilterType = "Select Filter Type"
        }
        
        struct UpdateJWT {
            static let title = "Update JWT Auth Token"
            static let subheading = ""
            static let mainButton = "Authenticate"
            
            static let userStateTitle = "User State"
            static let userStatePlaceholder = "User State"
            
            static let uuidTitle = "UUID"
            static let uuidPlaceholder = "UUID"

            static let tokenTitle = "JWT Token"
            static let tokenPlaceholder = "JWT Token"
            
            static let alertMessage = "Please enter a valid JWT"
        }
        
        struct LogEvent {
            static let title = "Log User Event"
            static let subheading = ""
            static let mainButton = "Log Event"
            
            static let eventNameTitle = "Event Name"
            static let eventNamePlaceholder = "Enter event name"
            
            static let eventValueTitle = "Event Value"
            static let eventValuePlaceholder = "Enter event value"
            static let eventValueDescription = "Please enter the event value in the below fomrat. Eg:Key1: value1, key2: value2"
        }
        
        struct ChangeLanguage {
            static let subheading = ""
            static let mainButton = "Change"
            
            static let pickerTitle = "SupportedLanguage"
            static let widgetLanguage = "Widget Language"
            static let userLanguage = "User Language"

            static let defaultSelectedLanguageCode = "en"
            static let defaultSelectedLanguageDisplayName = "English"
        }
        
        struct UpdateConvOrBotAttributesView {
            static let mainButton = "Update"
        }
        
        struct UpdateCustomBotVariables {
            static let title = "Update Custom Bot Variables"
            static let subheading = ""
            static let textEditor = "Bot Variables"
            static let textEditorPlaceholder = "Enter bot variables json string here"
            static let textEditorDescription = """
                                             Please enter the bot variables data in the below json string format.
                                             {
                                              "status": "active",
                                              "type": 4
                                             }
                                             """
        }
        
        struct setConversationProperties {
            static let title = "Set Conversation Properties"
            static let subheading = ""
            static let textEditor = "Conversation Properties"
            static let textEditorPlaceholder = "Enter Conversation properties json string here"
            static let textEditorDescription = """
                                             Please enter the conversation properties data in the below json string format.
                                             {
                                              "status": "active",
                                              "type": 4
                                             }
                                             """
        }
        
        struct Configurations {
            static let title = "Configurations"
            static let subheading = ""
            static let mainButton = "Done"
            static let outboundEventsToggleTitle = "Listen Outbound Events"
            static let dismissButtonToggleTitle = "Show Dismiss Button"
        }
    }
    
    struct Orders {
        static let name = "Bomber Jacket"
        static let price = "49.99"
        static let color = "Black"
        static let size = "XS"
        static let currency = "$"
        static let colorPrefix = "Color: "
        static let sizePrefix = "Size: "
        static let statusPrefix = "Status:"
        static let separator = " | "
        static let getHelp = "Get Help"
        static let viewSummary = "View Summary"
        struct Status {
            static let processing = "Processing"
            static let delivered = "Delivered"
        }
    }

    struct UserDefaultsKeys {
        static let selectedWidgetLanguageLocaleCode = "fw_selectedWidgetLanguageLocaleCode"
        static let selectedUserLanguageLocaleCode = "fw_selectedUserLanguageLocaleCode"
        static let conversationReferenceId = "fw_conversationReferenceId"
        static let topicNameForConversationReferenceId = "fw_topicNameForConversationReferenceId"
        static let externalID = "fw_externalID"
        static let restoreID = "fw_restoreID"
        static let userDetails = "fw_userDetails"
        static let tags = "fw_tags"
        static let tagsSelectOption = "fw_tagsSelectOption"
        static let source = "fw_source"
        static let appID = "fw_appID"
        static let appKey = "fw_appKey"
        static let domain = "fw_domain"
        static let widgetID = "fw_widgetID"
        static let jwt = "fw_jwt"
        static let conversationProperties = "fw_conversationProperties"
        static let botVariables = "fw_botVariables"
        static let headerProperty = "fw_headerProperty"
        static let contentProperty = "fw_contentProperty"
    }
    
    struct PreviewProvider {
        static let sampleText = "Sample Text"
        static let emptyText = ""
    }
    
    struct AccessibilityIdentifiers {
        static let email = "Email"
        static let password = "Password"
        static let signIn = "Sign In"
        static let dismiss = "Dismiss"
        static let myOrders = "My Orders"
        static let settings = "Develoepr Settings"
        static let contactUs = "Contact Us"
        static let productsView = "productsView"
        static let showFaqs = "showFaqs"
    }
}

struct Images {
    static let iconBack = "iconBack"
    static let background = "background"
    static let iconGoogle = "iconGoogle"
    static let iconFacebook = "iconFacebook"
    static let iconApple = "iconApple"
    static let iconHomeFilled = "iconHomeFilled"
    static let iconHome = "iconHome"
    static let iconFavouritesFilled = "iconFavouritesFilled"
    static let iconFavourites = "iconFavourites"
    static let iconCartFilled = "iconCartFilled"
    static let iconCart = "iconCart"
    static let systemCloseFilled = "xmark.circle.fill"
    static let userImage = "userImage"
    static let iconLogout = "iconLogout"
    static let orderImageOne = "itemImage1"
    static let orderImageTwo = "itemImage2"
    static let iconHelp = "iconHelp"
    static let iconSummary = "iconSummary"
    static let homeScreen = "homeScreen"
    static let iconSideMenu = "iconSideMenu"
    static let iconCartRound = "iconCartRound"
    static let iconFAQsRound = "iconFAQsRound"
    static let productImage = "productImage"
    static let productOptions = "productOptions"
    static let iconAddToCart = "iconAddToCart"
    static let checkoutArrow = "checkoutArrow"
    static let cartList = "cartList"
    static let orderPlaced = "orderPlaced"
}

struct Colors {
    static let darkBlue = "buttonDarkBlack"
    static let backgroundGray = "backgroundGray"
    static let backgroundDarkGray = "backgroundDarkGray"
}

struct Dimensions {
    struct DismissButton {
        static let height: CGFloat = 60
        static let width: CGFloat = 60
        static let trailingSpacing: CGFloat = 16
        static let bottomSpacing: CGFloat = 64
    }
}

// TODO: Will change with change in account
struct SDKTopicConfiguration {
    static let topicName = "Topic 3"
    struct ParallelConversation {
        static let identifier = "Get Help"
        static let identifierOne = "Get Help 1"
        static let identifierTwo = "Get Help 2"
    }
}
