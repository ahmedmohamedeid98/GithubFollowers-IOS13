//
//  GFUserInfoHeaderVC.swift
//  GithubFollowers
//
//  Created by Mac OS on 7/26/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    let avatarImageView         = GFAvatarImageView(frame: .zero)
    let usernameTitleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameSecondaryLabel      = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView       = UIImageView()
    let locationSecondaryLabel  = GFSecondaryTitleLabel(fontSize: 18)
    let bioBodyLabel            = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user   = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureLayoutElements()
    }
    
    private func configureLayoutElements() {
        avatarImageView.downlaodedImage(from: user.avatarUrl)
        usernameTitleLabel.text     = user.login
        nameSecondaryLabel.text     = user.name
        locationSecondaryLabel.text = user.location ?? "No Location"
        locationImageView.image     = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        bioBodyLabel.text           = user.bio ?? "No bio avaliable"
    }
    
    private func layoutUI() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameTitleLabel)
        view.addSubview(nameSecondaryLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationSecondaryLabel)
        view.addSubview(bioBodyLabel)
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding:CGFloat          = 20
        let textImagePadding:CGFloat = 12
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameTitleLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameTitleLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameSecondaryLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameSecondaryLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameSecondaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameSecondaryLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationSecondaryLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationSecondaryLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationSecondaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationSecondaryLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioBodyLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioBodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bioBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioBodyLabel.heightAnchor.constraint(equalToConstant: 60)
        
        ])
    }
}
