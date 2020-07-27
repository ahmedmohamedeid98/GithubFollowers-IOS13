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
        case userInfo(String)
        
        var url: URL? {
            switch self {
                case .followers(let username, let page):
                    return URL(string: baseURL + "\(username)/followers?page=\(page)&per_page=100")
                case .userInfo(let username): return URL(string: baseURL + "\(username)")
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
        APIRequest(url: url, responseClass: [Follower].self, completed: completed)
    }
    
    func getUserInfo(for username: String, completed: @escaping(Result<User, ErrorMessage>)->()) {
        
        guard let url = EndPoint.userInfo(username).url else {
            completed(.failure(.invalidUsername))
            return
        }
        APIRequest(url: url, responseClass: User.self, completed: completed)
    }
    
    
    
    func APIRequest<T: Decodable>(url: URL, responseClass: T.Type, completed: @escaping (Result<T, ErrorMessage>) -> () ) {
        
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
                let res = try decoder.decode(responseClass.self, from: safeData)
                completed(.success(res))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
