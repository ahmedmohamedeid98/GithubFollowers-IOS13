//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Mac OS on 6/22/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class NetworkManager {
    
    //MARK:- Properities
    
    static let shared   = NetworkManager()
    static let baseURL  = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    enum EndPoint {
        case followers(String, Int)
        
        var url: URL? {
            switch self {
                case .followers(let username, let page):
                    return URL(string: baseURL + "\(username)/followers?page=\(page)&per_page=100")
            }
        }
    }
    
    
    //MARK:- Init
    private init() {}
    
    
    
    //MARK:- Methods
    func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], ErrorMessage>)->()) {
        
        guard let url = EndPoint.followers(username, page).url else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let safeData = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: safeData)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
