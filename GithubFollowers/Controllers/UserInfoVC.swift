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
        
        if let username = username { print(username) }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    

}
