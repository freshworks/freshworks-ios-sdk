//
//  KeyboardObserver.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 29/04/24.
//

import Foundation
import UIKit

final class KeyboardObserver {
    static let shared = KeyboardObserver()
    var keyboardHeightChangeUpdate: ((Double) -> Void)?
    
    private(set) var keyboardHeight = 0.0 {
        didSet {
            if keyboardHeight != oldValue {
                keyboardHeightChangeUpdate?(keyboardHeight)
            }
        }
    }

    private init() { }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    func startObserving() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }

    @objc private func keyboardDidHide() {
        keyboardHeight = 0.0
    }
}
