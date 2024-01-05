//
//  Tabbar+Extensions.swift
//  SouthWest
//
//  Created by Pramit Tewari on 06/12/23.
//

import UIKit
import Foundation

extension UIView {
    
    func allSubviews() -> [UIView] {
        var allSubviews = subviews
        for subview in subviews {
            allSubviews.append(contentsOf: subview.allSubviews())
        }
        return allSubviews
    }
    
}

extension UITabBar {
    
    private static var originalY: Double?
    
    static public func setHidden(_ hidden: Bool) {
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        windowScene?.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ view in
            
            if let tabBar = view as? UITabBar {
                if !tabBar.isHidden && hidden {
                    
                    if let y = tabBar.superview?.frame.origin.y {
                        originalY = Double(y)
                    }
                    
                } else if tabBar.isHidden && !hidden {
                    
                    guard let originalY else { return }
                    tabBar.superview?.frame.origin.y = originalY
                }
                
                tabBar.isHidden = hidden
                tabBar.superview?.setNeedsLayout()
                tabBar.superview?.layoutIfNeeded()
            }
        })
    }
}
