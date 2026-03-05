//
//  GitHubService.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "You reach the limit of API calls, please try again later."
        case .decodingError:
            return "An error occurred while processing the data."
        }
    }
}

final class GitHubService: GitHubServiceProtocol {

    // MARK: - Properties
    private let baseURL = "https://api.github.com"
    
    // MARK: - Methods
    func fetchUserRepos(username: String) async throws -> [Repository] {
        guard let url = URL(string: "\(baseURL)/users/\(username)/repos") else {
            throw NetworkError.invalidURL
        }
        return try await fetchData(from: url)
    }
    
    func fetchRepoDetails(owner: String, repo: String) async throws -> Repository {
        guard let url = URL(string: "\(baseURL)/repos/\(owner)/\(repo)") else {
            throw NetworkError.invalidURL
        }
        return try await fetchData(from: url)
    }
    
    func fetchRepoTags(owner: String, repo: String) async throws -> [Tag] {
        guard let url = URL(string: "\(baseURL)/repos/\(owner)/\(repo)/tags") else {
            throw NetworkError.invalidURL
        }
        return try await fetchData(from: url)
    }
    
    // MARK: - Private
    private func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
