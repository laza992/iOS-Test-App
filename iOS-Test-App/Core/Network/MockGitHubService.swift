//
//  MockGitHubService.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import Foundation

final class MockGitHubService: GitHubServiceProtocol {
    // MARK: - Properties
    var shouldReturnError = false
    
    // MARK: - Methods
    func fetchUserRepos(username: String) async throws -> [Repository] {
        if shouldReturnError { throw NetworkError.invalidResponse }
        
        let mockOwner = User(login: "octocat", avatarUrl: "https://mockurl.com/avatar")
        return [
            Repository(id: 1, name: "Hello-World", openIssuesCount: 2, forksCount: 5, watchersCount: 10, owner: mockOwner),
            Repository(id: 2, name: "Test", openIssuesCount: 0, forksCount: 1, watchersCount: 3, owner: mockOwner)
        ]
    }
    
    func fetchRepoDetails(owner: String, repo: String) async throws -> Repository {
        if shouldReturnError { throw NetworkError.invalidResponse }
        
        let mockOwner = User(login: owner, avatarUrl: "https://mockurl.com/avatar")
        return Repository(id: 1, name: repo, openIssuesCount: 0, forksCount: 10, watchersCount: 20, owner: mockOwner)
    }
    
    func fetchRepoTags(owner: String, repo: String) async throws -> [Tag] {
        if shouldReturnError { throw NetworkError.invalidResponse }
        
        return [
            Tag(name: "v1.0", commit: Commit(sha: "8a6b9c...")),
            Tag(name: "v2.0", commit: Commit(sha: "9f1d2e..."))
        ]
    }
}
