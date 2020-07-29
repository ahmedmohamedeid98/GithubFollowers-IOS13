//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Mac OS on 7/29/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repo, gist, follower, following
}

class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.tintColor   = .label
        symbolImageView.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemType: ItemInfoType, withCount count: Int) {
        
        switch itemType {
            case .repo:
                symbolImageView.image = UIImage(systemName: SFSymbols.repo)
                titleLabel.text       = "Public Repo"
            case .gist:
                symbolImageView.image = UIImage(systemName: SFSymbols.gist)
                titleLabel.text       = "Public Gist"
            case .follower:
                symbolImageView.image = UIImage(systemName: SFSymbols.followers)
                titleLabel.text       = "Followers"
            case .following:
                symbolImageView.image = UIImage(systemName: SFSymbols.following)
                titleLabel.text       = "Following"
        }
        
        countLabel.text = String(count)
    }
    
}
