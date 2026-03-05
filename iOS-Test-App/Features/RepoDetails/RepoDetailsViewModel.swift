//
//  RepoDetailsViewModel.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/5/26.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class RepoDetailsViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var repositoryDetails: Repository?
    @Published var tags: [Tag] = []
    
    private let networkService: GitHubServiceProtocol
    private let owner: String
    private let repoName: String
    
    // MARK: - Init
    init(networkService: GitHubServiceProtocol, owner: String, repoName: String) {
        self.networkService = networkService
        self.owner = owner
        self.repoName = repoName
    }
    
    // MARK: - Methods
    func fetchAllData() async {
        isLoading = true
        errorMessage = nil
        do {
            async let fetchedRepo = networkService.fetchRepoDetails(owner: owner, repo: repoName)
            async let fetchedTags = networkService.fetchRepoTags(owner: owner, repo: repoName)
            self.repositoryDetails = try await fetchedRepo
            self.tags = try await fetchedTags
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
