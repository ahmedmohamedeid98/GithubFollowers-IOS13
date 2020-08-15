//
//  PersistanceManager.swift
//  GithubFollowers
//
//  Created by Mac OS on 8/15/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import Foundation

enum PersistanceManagerActions {
    case add, remove
}

enum PersistanceManager {
    static let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func update(with follower: Follower, actionType: PersistanceManagerActions, completion: @escaping(ErrorMessage?) -> () ) {
        retriveFavorites { result in
            switch result {
                case .success(let favorites):
                    var retrivedFavorites = favorites
                    
                    switch actionType {
                        case .add:
                            guard !retrivedFavorites.contains(follower) else {
                                completion(.alreadyInFavorites)
                                return
                            }
                            retrivedFavorites.append(follower)

                        case .remove:
                            retrivedFavorites.removeAll { $0.login == follower.login }
                    }
                completion(save(favorites: retrivedFavorites))
                
                case .failure(let err):
                    completion(err)
            }
        }
    }
    
    static func retriveFavorites(completion: @escaping(Result<[Follower], ErrorMessage>) -> ()) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorites))
        }
    }
    
    static func save(favorites: [Follower]) -> ErrorMessage? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(favorites)
            defaults.set(data, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorites
        }
    }
}
