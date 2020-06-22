//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Mac OS on 6/22/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import Foundation

enum ErrorMessage: String {
    case invalidUsername    = "This username created an invalid request. please try again."
    case unableToComplete   = "Unable to compelete your request, please check your internet connection."
    case invalidResponse    = "Invalid response from a server. please try again."
    case invalidData        = "The data received from the server was invalid, please try again."
}
