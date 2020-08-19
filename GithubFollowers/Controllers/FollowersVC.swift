//
//  FollowersVC.swift
//  GithubFollowers
//
//  Created by Mac OS on 6/21/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

protocol FollowersVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowersVC: UIViewController {

    //MARK:- Properities
    enum Section { case main }
    
    var username: String!
    var followers               = [Follower]()
    var filterFollowers         = [Follower]()
    var isSearching:Bool        = false
    var page                    = 1
    var hasMoreFollowers        = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    //MARK:- Init
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username   = username
        title           = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configuerSearchController()
        configureCollectionView()
        getFollowers(page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK:- Methods
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton                      = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem   = addButton
    }
    
    private func configuerSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchBar.placeholder                  = "Search for a username"
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.delegate                     = self
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.backgroundColor = .systemBackground
    }
    
    private func getFollowers(page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
                case .success(let followers):
                    if followers.count < 100 { self.hasMoreFollowers = false }
                    self.followers.append(contentsOf: followers)
                    if self.followers.isEmpty {
                        DispatchQueue.main.async {
                            self.showEmptyStateView(withMessage: "This user doesn't have any followers. Go follow them 🙂.", onView: self.view)
                        }
                        return
                    }
                    self.updateData(on: self.followers)
                case .failure(let error):
                    self.presentGFAlertOnTheMainThread(title: "Failure", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async{ self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    @objc func addButtonTapped() {
        self.showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
                case .success(let user):
                    let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                    PersistanceManager.update(with: favorite, actionType: .add) { error in
                        guard let err = error else {
                            self.presentGFAlertOnTheMainThread(title: "Success!", message: "You have successfully favorited this user 🥳.", buttonTitle: "Hooray!")
                            return
                        }
                        self.presentGFAlertOnTheMainThread(title: "Failure", message: err.rawValue, buttonTitle: "Ok")
                        
                }
                case .failure(let error):
                    self.presentGFAlertOnTheMainThread(title: "Failure", message: error.rawValue , buttonTitle: "Ok")
            }
        }
    }
    
    
}

extension FollowersVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY             = scrollView.contentOffset.y
        let contentHeight       = scrollView.contentSize.height
        let height              = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filterFollowers : followers
        let follower    = activeArray[indexPath.item]
        
        let destVC      = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let destNC      = UINavigationController(rootViewController: destVC)
        present(destNC, animated: true)
    }
}

extension FollowersVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filterFollowers  = followers.filter {
            $0.login.lowercased()
                .replacingOccurrences(of: " ", with: "")
                .contains(filter.lowercased().replacingOccurrences(of: " ", with: ""))
        }
        updateData(on: filterFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if isSearching {
            updateData(on: self.followers)
            isSearching = false
        }
    }
}

extension FollowersVC: FollowersVCDelegate {
    
    func didRequestFollowers(for username: String) {
        collectionView.setContentOffset(.zero, animated: true)
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        filterFollowers.removeAll()
        getFollowers(page: page)
    }
    
}
