//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Mac OS on 6/21/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius        = 10.0
        layer.borderWidth         = 2.0
        layer.borderColor         = UIColor.systemGray4.cgColor
        
        textColor                 = .label
        tintColor                 = .label
        textAlignment             = .center
        font                      = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize           = 12.0
        
        backgroundColor           = .tertiarySystemBackground
        autocorrectionType        = .no
        returnKeyType             = .go
        clearButtonMode           = .whileEditing
        placeholder               = "Enter a username"
    }
}
