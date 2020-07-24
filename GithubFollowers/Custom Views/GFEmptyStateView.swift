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
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    
    
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(emptyStateImage)
        
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        
        emptyStateImage.image       = UIImage(named: "empty-state-logo")
        emptyStateImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            emptyStateImage.widthAnchor.constraint(equalTo: widthAnchor , multiplier: 1.3),
            emptyStateImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            emptyStateImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            emptyStateImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40)
        ])
    }
    
}
