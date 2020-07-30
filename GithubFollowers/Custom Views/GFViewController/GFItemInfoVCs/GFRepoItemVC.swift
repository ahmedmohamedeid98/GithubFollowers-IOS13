//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Mac OS on 7/29/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoOne.set(itemType: .repo, withCount: user.publicRepos)
        itemInfoTwo.set(itemType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func setButtonAction() {
        delegate.didTapGithubProfile(for: user)
    }
    
}
