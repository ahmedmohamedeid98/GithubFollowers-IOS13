//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Mac OS on 7/26/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {

    var username: String?
    var headerView          = UIView()
    var userItemOne         = UIView()
    var userItemTwo         = UIView()
    var dateLabel           = GFBodyLabel(textAlignment: .center)
    var itemsView: [UIView] = []
    weak var delegate: FollowersVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame  = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func configureViewController() {
        view.backgroundColor                = .systemBackground
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = doneButton
    }
    
    private func getUserInfo() {
        guard let username = username else { return }
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch result {
                case .success(let user):
                    DispatchQueue.main.async { self.configureUIElements(with: user) }
                
                case .failure(let error):
                    self.presentGFAlertOnTheMainThread(title: "Something want wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func configureUIElements(with user: User) {
        let repoItemVC          = GFRepoItemVC(user: user)
        repoItemVC.delegate     = self
        
        let followerItemVC      = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.userItemOne)
        self.add(childVC: followerItemVC, to: self.userItemTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertDateToDisplayingFormate())"
    }
    
    func layoutUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        itemsView               = [headerView, userItemOne, userItemTwo, dateLabel]
        for itemView in itemsView {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            userItemOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            userItemOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            userItemTwo.topAnchor.constraint(equalTo: userItemOne.bottomAnchor, constant: padding),
            userItemTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: userItemTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else { return }
        self.presentSafariController(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        // check if the user has follower or not
        guard user.followers != 0 else {
            presentGFAlertOnTheMainThread(title: "No Followers", message: "this user has no followers, help him to get one.", buttonTitle: "I'm sorry, 😟")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
