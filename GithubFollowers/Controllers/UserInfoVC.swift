//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Mac OS on 7/26/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String?
    var headerView          = UIView()
    var userItemOne         = UIView()
    var userItemTwo         = UIView()
    var itemsView: [UIView] = []
    
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
                    DispatchQueue.main.async {
                        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                        self.add(childVC: GFRepoItemVC(user: user), to: self.userItemOne)
                        self.add(childVC: GFFollowerItemVC(user: user), to: self.userItemTwo)
                }
                case .failure(let error):
                    self.presentGFAlertOnTheMainThread(title: "Something want wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    func layoutUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        itemsView               = [headerView, userItemOne, userItemTwo]
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
            userItemTwo.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    

}
