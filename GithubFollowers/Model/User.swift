//
//  User.swift
//  GithubFollowers
//
//  Created by Mac OS on 6/22/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarURL: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var following: Int
    var followers: Int
    var htmlUrl: String
    var createdAt: String
}
