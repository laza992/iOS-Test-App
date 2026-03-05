//
//  UserReposViewProtocol.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import UIKit

enum UserReposViewState {
    case idle
    case loading
    case success
    case error(String)
}

protocol UserReposViewProtocol: AnyObject {
    func updateState(_ state: UserReposViewState)
}

protocol UserReposPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfRows() -> Int
    func repo(at index: Int) -> Repository
    func didSelectRow(at index: Int)
}

protocol UserReposInteractorProtocol: AnyObject {
    func fetchRepos() async throws -> [Repository]
}

protocol UserReposRouterProtocol: AnyObject {
    func navigateToRepoDetails(from view: UserReposViewProtocol, repo: Repository)
}
