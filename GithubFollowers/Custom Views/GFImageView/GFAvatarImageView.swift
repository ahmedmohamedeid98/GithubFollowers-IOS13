//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Mac OS on 6/22/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let cache       = NetworkManager.shared.cache
    let placeholder = Images.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configure() {
        layer.cornerRadius  = 10.0
        clipsToBounds       = true
        image               = placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
}



