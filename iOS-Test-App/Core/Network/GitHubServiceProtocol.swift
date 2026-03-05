//
//  GitHubServiceProtocol.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import Foundation

protocol GitHubServiceProtocol {
    func fetchUserRepos(username: String) async throws -> [Repository]
    func fetchRepoDetails(owner: String, repo: String) async throws -> Repository
    func fetchRepoTags(owner: String, repo: String) async throws -> [Tag]
}
