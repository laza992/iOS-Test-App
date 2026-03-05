//
//  RepoDetailsViewModelTests.swift
//  iOS-Test-App
//
//  Created by Lazar Stojkovic on 3/5/26.
//

import XCTest
@testable import iOS_Test_App

@MainActor
final class RepoDetailsViewModelTests: XCTestCase {
    
    var sut: RepoDetailsViewModel! // SUT - System Under Test
    var mockService: MockGitHubService!

    override func setUp() {
        super.setUp()
        mockService = MockGitHubService()
        sut = RepoDetailsViewModel(networkService: mockService, owner: "test", repoName: "test")
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }

    func testFetchAllData_Success() async {
        await sut.fetchAllData()
        XCTAssertFalse(sut.isLoading, "Loading should be false after finish")
        XCTAssertNotNil(sut.repositoryDetails, "Details should be loaded")
        XCTAssertEqual(sut.tags.count, 2, "We should have 2 tags")
        XCTAssertNil(sut.errorMessage, "Error message should be nil")
    }
}
