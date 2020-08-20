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
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let res                         = try decoder.decode(responseClass.self, from: safeData)
                completed(.success(res))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping(UIImage?) -> ()) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url   = URL(string: urlString) else {
            completion(nil)
            return
        }
        let task  = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil, let response = response as? HTTPURLResponse,
            response.statusCode == 200, let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
    
}
