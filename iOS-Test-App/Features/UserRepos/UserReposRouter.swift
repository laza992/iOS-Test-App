//
//  UserReposRouter.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import UIKit
import SwiftUI

final class UserReposRouter: UserReposRouterProtocol {

    // MARK: - Methods
    static func createModule(with networkService: GitHubServiceProtocol) -> UIViewController {
        let view = UserReposViewController()
        let interactor = UserReposInteractor(networkService: networkService)
        let router = UserReposRouter()
        let presenter = UserReposPresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
    func navigateToRepoDetails(from view: UserReposViewProtocol, repo: Repository) {
        guard let sourceView = view as? UIViewController else { return }
        let networkService = GitHubService()
        let viewModel = RepoDetailsViewModel(
            networkService: networkService,
            owner: repo.owner.login,
            repoName: repo.name
        )
        let detailsView = RepoDetailsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: detailsView)
        hostingController.title = repo.name
        sourceView.navigationController?.pushViewController(hostingController, animated: true)
    }
}
