//
//  ToastView.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 24/04/24.
//

import Foundation
import UIKit

class ToastView: UIView {
    private let messageLabel: UILabel
    
    init(message: String?) {
        messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = .systemFont(ofSize: 12, weight: .regular)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .black
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .toastBackgroundColor
        
        layer.cornerRadius = 12
        clipsToBounds = true
        
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}
