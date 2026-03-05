//
//  Repository.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let openIssuesCount: Int
    let forksCount: Int
    let watchersCount: Int
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case openIssuesCount = "open_issues_count"
        case forksCount = "forks_count"
        case watchersCount = "watchers_count"
    }
}
