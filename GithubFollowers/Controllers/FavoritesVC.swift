//
//  FavoritesVC.swift
//  GithubFollowers
//
//  Created by Mac OS on 6/20/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        PersistanceManager.retriveFavorites { result in
            switch result {
                case .success(let favorites):
                    print(favorites)
                case .failure(_):
                    break
            }
        }
    }

}
