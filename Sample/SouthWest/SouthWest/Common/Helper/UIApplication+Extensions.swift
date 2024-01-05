//
//  UIApplication+Extensions.swift
//  SouthWest
//
//  Created by Pramit Tewari on 13/12/23.
//

import UIKit

extension UIApplication {
    static var topView: UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
           let rootViewController = keyWindow.rootViewController  else {
            return nil
        }
        
        var topViewController = rootViewController
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        
        return topViewController
    }
}
