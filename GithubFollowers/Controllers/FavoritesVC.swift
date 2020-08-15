//
//  FavoritesVC.swift
//  GithubFollowers
//
//  Created by Mac OS on 6/20/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    let tableView               = UITableView()
    var favorites: [Follower]   = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetFavorites()
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title                = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func GetFavorites() {
        PersistanceManager.retriveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let favorites):
                    if favorites.isEmpty {
                        self.showEmptyStateView(withMessage: "No Favorites?!!\n add one to favorite screen.", onView: self.view)
                    } else {
                        self.favorites = favorites
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                case .failure(let err):
                    self.presentGFAlertOnTheMainThread(title: "Something went wrong", message: err.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
    }
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell     = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseID, for: indexPath) as! FavoritesCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let favorite            = favorites[indexPath.row]
        let followersVC         = FollowersVC()
        followersVC.username    = favorite.login
        followersVC.title       = favorite.login
        navigationController?.pushViewController(followersVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        self.favorites.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        
        PersistanceManager.update(with: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let err  = error else { return }
            self.presentGFAlertOnTheMainThread(title: "Unable to remove", message: err.rawValue, buttonTitle: "Ok")
        }
    }
}
