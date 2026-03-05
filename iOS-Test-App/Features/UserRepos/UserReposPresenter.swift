//
//  UserReposPresenter.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import Foundation

@MainActor
final class UserReposPresenter: UserReposPresenterProtocol {

    // MARK: - Properties
    weak var view: UserReposViewProtocol?
    private let interactor: UserReposInteractorProtocol
    private let router: UserReposRouterProtocol
    private var repositories: [Repository] = []
    
    // MARK: - Init
    init(interactor: UserReposInteractorProtocol, router: UserReposRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        view?.updateState(.loading)
        Task {
            do {
                let repos = try await interactor.fetchRepos()
                self.repositories = repos
                view?.updateState(.success)
            } catch {
                view?.updateState(.error(error.localizedDescription))
            }
        }
    }
    
    func didSelectRepo(_ repo: Repository) {
        guard let view = view else { return }
        router.navigateToRepoDetails(from: view, repo: repo)
    }
    
    func numberOfRows() -> Int {
        return repositories.count
    }
    
    func repo(at index: Int) -> Repository {
        return repositories[index]
    }
    
    func didSelectRow(at index: Int) {
        let selectedRepo = repositories[index]
        guard let view = view else { return }
        router.navigateToRepoDetails(from: view, repo: selectedRepo)
    }
}
