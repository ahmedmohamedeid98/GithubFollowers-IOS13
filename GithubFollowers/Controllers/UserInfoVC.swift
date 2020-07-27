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
    var headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor                = .systemBackground
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = doneButton
        layoutUI()
        guard let username = username else { return }
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch result {
                case .success(let user):
                    DispatchQueue.main.async { self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView) }
                case .failure(let error):
                    self.presentGFAlertOnTheMainThread(title: "Something want wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame  = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    

}
