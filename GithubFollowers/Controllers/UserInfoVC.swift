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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor                = .systemBackground
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = doneButton
        
        guard let username = username else { return }
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch result {
                case .success(let user):
                print(user)
                case .failure(let error):
                    self.presentGFAlertOnTheMainThread(title: "Something want wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    

}
