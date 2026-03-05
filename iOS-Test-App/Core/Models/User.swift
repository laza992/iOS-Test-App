//
//  User.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
