//
//  usersTests.swift
//  Kaidee AssignmentTests
//
//  Created by Peerapat Prommaha on 22/3/2564 BE.
//

@testable import Kaidee_Assignment
import XCTest

class UsersPresenterTests: XCTestCase {
    // MARK: Subject under test
        
    var presenter: UsersPresenter!
    var spy: UsersDisplayLogicSpy!
        
    // MARK: Test lifecycle
        
    override func setUp() {
        super.setUp()
        setupUsersPresenter()
    }
        
    override func tearDown() {
        super.tearDown()
        presenter = nil
        spy = nil
    }
        
    // MARK: Test setup
        
    func setupUsersPresenter() {
        presenter = UsersPresenter()
        spy = UsersDisplayLogicSpy()
        presenter.viewController = spy
    }
        
    // MARK: Test doubles
        
    final class UsersDisplayLogicSpy: UsersDisplayLogic {
        var isDisplayUsersCalled: Bool = false
        var usersViewModel: [UserModel]?
        var usersError: CommonError?
        var isDisplaySearchUsersCalled: Bool = false
        var searchUsersViewModel: SearchUserModel?
        var searchUsersError: CommonError?
        var isDisplayUserFavoriteCalled: Bool = false
        var userFavoriteViewModel: [UserModel]?

        func displayUsers(_ viewModel: Users.FetchUsers.ViewModel) {
            isDisplayUsersCalled = true
            switch viewModel.content {
            case .success(let result):
                usersViewModel = result
            case .failure(let error):
                usersError = error
            }
        }
                
        func displaySearchUsers(_ viewModel: Users.SearchUsers.ViewModel) {
            isDisplaySearchUsersCalled = true
            switch viewModel.content {
            case .success(let result):
                searchUsersViewModel = result
            case .failure(let error):
                searchUsersError = error
            }
        }
        
        func displayUserFavorite(_ data: [UserModel]) {
            isDisplayUserFavoriteCalled = true
            userFavoriteViewModel = data
        }
    }
        
    // MARK: Tests

    func testFetchUsersSuccess() {
        // Given
        let mockResponse: Users.FetchUsers.Response = Users.FetchUsers.Response(result: .success(UsersMockData.fetchUsersSuccessResponse()))
        // When
        presenter.presentUsers(response: mockResponse)
        // Then
        XCTAssertTrue(spy.isDisplayUsersCalled)
        XCTAssertEqual(spy.usersViewModel, UsersMockData.fetchUsersSuccessResponse())
    }
    
    func testFetchUsersError() {
        // Given
        let mockResponse: Users.FetchUsers.Response = Users.FetchUsers.Response(result: .failure(UsersMockData.failResponse()!))
        // When
        presenter.presentUsers(response: mockResponse)
        // Then
        XCTAssertTrue(spy.isDisplayUsersCalled)
        XCTAssertEqual(spy.usersError, UsersMockData.failResponse()!)
    }
    
    func testFetchUsersEmpty() {
        // Given
        let mockResponse: Users.FetchUsers.Response = Users.FetchUsers.Response(result: .success(UsersMockData.fetchUsersEmptyResponse()))
        // When
        presenter.presentUsers(response: mockResponse)
        // Then
        XCTAssertTrue(spy.isDisplayUsersCalled)
        XCTAssertNil(spy.usersViewModel)
    }
    
    func testSearchUsersSuccess() {
        // Given
        let mockResponse: Users.SearchUsers.Response = Users.SearchUsers.Response(result: .success(UsersMockData.searchUsersSuccessResponse()))
        // When
        presenter.presentSearchUsers(response: mockResponse)
        // Then
        XCTAssertTrue(spy.isDisplaySearchUsersCalled)
        XCTAssertEqual(spy.searchUsersViewModel, UsersMockData.searchUsersSuccessResponse())
    }
    
    func testSearchUsersError() {
        // Given
        let mockResponse: Users.SearchUsers.Response = Users.SearchUsers.Response(result: .failure(UsersMockData.failResponse()!))
        // When
        presenter.presentSearchUsers(response: mockResponse)
        // Then
        XCTAssertTrue(spy.isDisplaySearchUsersCalled)
        XCTAssertEqual(spy.searchUsersError, UsersMockData.failResponse()!)
    }
    
    func testSearchUsersEmpty() {
        // Given
        let mockResponse: Users.SearchUsers.Response = Users.SearchUsers.Response(result: .success(UsersMockData.searchUsersEmptyResponse()))
        // When
        presenter.presentSearchUsers(response: mockResponse)
        // Then
        XCTAssertTrue(spy.isDisplaySearchUsersCalled)
        XCTAssertNil(spy.searchUsersViewModel?.items)
    }
    
    func testFavoriteUsers() {
        // Given
        var mockResponse: [UserModel] = UsersMockData.fetchUsersSuccessResponse()!
        mockResponse[0].isFav = true
        // When
        presenter.presentUserFavorite(users: mockResponse)
        // Then
        XCTAssertTrue(spy.isDisplayUserFavoriteCalled)
        XCTAssertEqual(spy.userFavoriteViewModel, mockResponse)
    }
    
    func testUnFavoriteUsers() {
        // Given
        var mockResponse: [UserModel] = UsersMockData.fetchUsersSuccessResponse()!
        mockResponse[0].isFav = false
        // When
        presenter.presentUserFavorite(users: mockResponse)
        // Then
        XCTAssertTrue(spy.isDisplayUserFavoriteCalled)
        XCTAssertEqual(spy.userFavoriteViewModel, mockResponse)
    }
}
