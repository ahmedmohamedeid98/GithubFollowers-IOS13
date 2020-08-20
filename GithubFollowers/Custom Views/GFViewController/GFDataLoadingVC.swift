//
//  GFDataLoadingVC.swift
//  GithubFollowers
//
//  Created by Mac OS on 8/19/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    
    private var containerView: UIView!
    
    func showLoadingView() {
        containerView                   = UIView(frame: view.bounds)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        view.addSubview(containerView)
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
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
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(withMessage message: String, onView view: UIView) {
        DispatchQueue.main.async {
            let emptyStateView      = GFEmptyStateView(message: message)
            emptyStateView.frame    = view.bounds
            view.addSubview(emptyStateView)
        }
    }
    
}
