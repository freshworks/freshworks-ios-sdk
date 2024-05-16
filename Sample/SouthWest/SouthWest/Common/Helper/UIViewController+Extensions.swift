//
//  UIViewController+Extensions.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 24/04/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String?, duration: TimeInterval = 2, 
                   completion: (() -> Void)? = nil) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        let toastView = ToastView(message: message)
        toastView.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(toastView)
        
        let defaultBottomConstant: CGFloat = 16
        let initialBottomConstant = -KeyboardObserver.shared.keyboardHeight - defaultBottomConstant
        let bottomConstraint = toastView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor,
                                                                 constant: initialBottomConstant)
        
        KeyboardObserver.shared.keyboardHeightChangeUpdate = { (keyboardHeight) in
            UIView.animate(withDuration: 1) {
                bottomConstraint.constant = -keyboardHeight - defaultBottomConstant
            }
        }
        
        NSLayoutConstraint.activate([
            toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            toastView.leadingAnchor.constraint(greaterThanOrEqualTo: window.safeAreaLayoutGuide.leadingAnchor, 
                                               constant: 16),
            toastView.trailingAnchor.constraint(lessThanOrEqualTo: window.safeAreaLayoutGuide.trailingAnchor, 
                                                constant: -16),
            bottomConstraint
        ])
        toastView.transform = CGAffineTransform(translationX: 0, y: 80)
        
        UIView.animate(withDuration: 0.1,
                       animations: {
            toastView.transform = .identity
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2,
                           options: .curveEaseInOut,
                           animations: {
                toastView.transform = CGAffineTransform.identity
                toastView.alpha = 0
            }) { _ in
                toastView.removeFromSuperview()
                completion?() // Call completion handler after toast is dismissed
            }
        }
    }
}
