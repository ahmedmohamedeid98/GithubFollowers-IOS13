//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Mac OS on 6/21/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

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
    
    func showLoadingView() {
        containerView                   = UIView(frame: view.bounds)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        view.addSubview(containerView)
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicatorView.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(withMessage message: String) {
        DispatchQueue.main.async {
            let emptyStateView      = GFEmptyStateView(message: message)
            emptyStateView.frame    = self.view.bounds
            self.view.addSubview(emptyStateView)
        }
    }
}
