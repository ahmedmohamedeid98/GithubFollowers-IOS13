//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Mac OS on 6/21/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentSafariController(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func presentGFAlertOnTheMainThread(title: String, message: String, buttonTitle btnTitle: String) {
        DispatchQueue.main.async {
            let alert = GFAlertVC(title: title, message: message, buttonTitle: btnTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle   = .crossDissolve
            self.present(alert, animated: true)
        }
    }
}
