//
//  UserReposViewController.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import UIKit

final class UserReposViewController: UIViewController, UserReposViewProtocol {

    // MARK: - Properties
    var presenter: UserReposPresenterProtocol!
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - Methods
    func updateState(_ state: UserReposViewState) {
        switch state {
        case .idle:
            break
        case .loading:
            tableView.isHidden = true
            activityIndicator.startAnimating()
        case .success:
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
        case .error(let errorMessage):
            activityIndicator.stopAnimating()
            showErrorAlert(message: errorMessage)
        }
    }
    
    // MARK: - Private
    private func setupUI() {
        title = "Repositories"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        setupTableView()
        setupConstraints()
    }
        
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: RepoTableViewCell.reuseIdentifier)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource & Delegate
extension UserReposViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.reuseIdentifier, for: indexPath) as? RepoTableViewCell else {
            return UITableViewCell()
        }
        let repo = presenter.repo(at: indexPath.row)
        cell.configure(with: repo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath.row)
    }
}
