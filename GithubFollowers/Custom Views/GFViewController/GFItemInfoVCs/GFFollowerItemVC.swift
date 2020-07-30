//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Mac OS on 7/29/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit


class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoOne.set(itemType: .followers, withCount: user.followers)
        itemInfoTwo.set(itemType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func setButtonAction() {
        delegate.didTapGetFollowers(for: user)
    }
}

