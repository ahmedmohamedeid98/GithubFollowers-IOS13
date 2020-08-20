//
//  GFAlertContainer.swift
//  GithubFollowers
//
//  Created by Mac OS on 8/19/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class GFAlertContainer: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor       = .systemBackground
        layer.cornerRadius    = 16.0
        layer.borderWidth     = 2.0
        layer.borderColor     = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }

}
