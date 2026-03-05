//
//  RepoDetailsView.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/5/26.
//

import SwiftUI
import Combine

struct RepoDetailsView: View {
    @StateObject var viewModel: RepoDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 50)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    if let repo = viewModel.repositoryDetails {
                        headerView(for: repo)
                    }
                    
                    Divider()
    
                    Text("Tags")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    if viewModel.tags.isEmpty {
                        Text("No tags found.")
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    } else {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.tags, id: \.name) { tag in
                                tagRow(for: tag)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchAllData()
        }
    }
    
    @ViewBuilder
    private func headerView(for repo: Repository) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: repo.owner.avatarUrl)) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(repo.owner.login)
                        .font(.headline)
                    Text(repo.name)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            HStack(spacing: 24) {
                Label("\(repo.forksCount) forks", systemImage: "tuningfork")
                Label("\(repo.watchersCount) watchers", systemImage: "eye")
            }
            .font(.footnote)
            .foregroundColor(.secondary)
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    @ViewBuilder
    private func tagRow(for tag: Tag) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(tag.name)
                .font(.headline)
            Text(tag.commit.sha)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
                .truncationMode(.middle)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}
