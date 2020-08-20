//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Mac OS on 7/23/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    var messageLabel    = GFTitleLabel(textAlignment: .center, fontSize: 28)
    var emptyStateImage = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMessageLabelUI()
        configureEmptyStateImageUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configureMessageLabelUI() {
        addSubview(messageLabel)
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        
        let messageLabelYCenter: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -120
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: messageLabelYCenter).isActive = true
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureEmptyStateImageUI() {
        addSubview(emptyStateImage)
        emptyStateImage.image       = Images.emptySate
        emptyStateImage.translatesAutoresizingMaskIntoConstraints = false
        
        let emptyStateBottomConstraint: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 100 : 50
        emptyStateImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: emptyStateBottomConstraint).isActive = true

        NSLayoutConstraint.activate([
            emptyStateImage.widthAnchor.constraint(equalTo: widthAnchor , multiplier: 1.1),
            emptyStateImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.1),
            emptyStateImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 150)
        ])
    }
    
}
