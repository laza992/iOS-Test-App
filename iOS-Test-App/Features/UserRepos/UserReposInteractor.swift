//
//  UserReposInteractor.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import Foundation

final class UserReposInteractor: UserReposInteractorProtocol {
    
    // MARK: - Properties
    private let networkService: GitHubServiceProtocol
    private let username = "octocat"
    
    // MARK: - Init
    init(networkService: GitHubServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    func fetchRepos() async throws -> [Repository] {
        return try await networkService.fetchUserRepos(username: username)
    }
}
