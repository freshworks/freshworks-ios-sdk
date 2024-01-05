
Pod::Spec.new do |s|

  s.name         		 = "FreshworksSDK"
  s.version      		 = "0.0.1-beta"
  s.summary      		 = "Freshworks iOS SDK - Modern messaging software that your sales and customer engagement teams will love."
  s.description  		 = <<-DESC
                   			Modern messaging software that your sales and customer engagement teams will love.
                   			DESC
  s.homepage     		 = "https://www.freshworks.com"
  s.license 	 		 = { :type => 'Commercial', :file => 'FreshworksSDK/LICENSE', :text => 'See https://www.freshworks.com/terms' }
  s.author       		 = { "Freshworks" => "support@freshchat.com" }
  s.social_media_url     = "https://twitter.com/freshchatapp"
  s.platform     		 = :ios, "14.0"
  s.source       		 = { :git => "https://github.com/freshworks/freshworks-ios-sdk.git", :tag => "v#{s.version}" }
  s.frameworks 			 = "Foundation", "SystemConfiguration", "Security", "WebKit" 
  s.requires_arc 		 = true
  s.preserve_paths      = "FreshworksSDK.xcframework"
  s.vendored_frameworks = "FreshworksSDK.xcframework"

end
