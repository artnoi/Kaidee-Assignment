//
//  UsersInteractorTests.swift
//  Kaidee AssignmentTests
//
//  Created by Peerapat Prommaha on 22/3/2564 BE.
//

@testable import Kaidee_Assignment
import XCTest

class UsersInteractorTest: XCTestCase {
    // MARK: Subject under test

    var interactor: UsersInteractor!
    var presenter: UsersPresentationLogicSpy!
    var worker: UsersWorkerSpy!
    
    // MARK: Test lifecycle
        
    override func setUp() {
        super.setUp()
        setup()
    }
        
    override func tearDown() {
        super.tearDown()
        interactor = nil
        presenter = nil
        worker = nil
    }
        
    // MARK: Test setup
        
    func setup() {
        interactor = UsersInteractor()
        worker = UsersWorkerSpy()
        interactor = UsersInteractor(worker: worker)
        presenter = UsersPresentationLogicSpy()
        interactor.presenter = presenter
    }
        
    final class UsersPresentationLogicSpy: UsersPresentationLogic {
        var usersResponseSuccess: [UserModel]?
        var errorResponse: CommonError?
        var usersFavorite: [UserModel]?
        var usersSearch: SearchUserModel?
        
        func presentUsers(response: Users.FetchUsers.Response) {
            switch response.result {
            case .success(let result):
                usersResponseSuccess = result
            case .failure(let error):
            errorResponse = error
            }
        }
        
        func presentUserFavorite(users: [UserModel]) {
            usersFavorite = users
        }
        
        func presentSearchUsers(response: Users.SearchUsers.Response) {
            switch response.result {
            case .success(let result):
                usersSearch = result
            case .failure(let error):
            errorResponse = error
            }
        }
    }

    final class UsersWorkerSpy: UsersWorker {
        var isGetUsersSuccess: Bool = false
        var isSearchUsersSuccess: Bool = false
        
        override func getUsers(completion: @escaping (Result<[UserModel]?, CommonError>) -> Void) {
            if isGetUsersSuccess {
                let mockData = UsersMockData.fetchUsersSuccessResponse()
                completion(.success(mockData))
            } else {
                let mockData = UsersMockData.failResponse()
                completion(.failure(mockData!))
            }
        }
        
        override func searchUsers(request: Users.SearchUsers.Request, completion: @escaping (Result<SearchUserModel?, CommonError>) -> Void) {
            if isSearchUsersSuccess {
                let mockData = UsersMockData.searchUsersSuccessResponse()
                completion(.success(mockData))
            } else {
                let mockData = UsersMockData.failResponse()
                completion(.failure(mockData!))
            }
        }
    }
    
    // MARK: Test doubles

    func testFetchUsersSuccess() {
        // Given
        let expectViewModel: [UserModel] = UsersMockData.fetchUsersSuccessResponse()!
        worker.isGetUsersSuccess = true
        // When
        interactor.fetchUsers()
        // Then
        XCTAssertEqual(presenter.usersResponseSuccess, expectViewModel)
    }
    
    func testFetchUsersFail() {
        // Given
        let expectViewModel: CommonError = UsersMockData.failResponse()!
        worker.isGetUsersSuccess = false
        // When
        interactor.fetchUsers()
        // Then
        XCTAssertEqual(presenter.errorResponse, expectViewModel)
    }
    
    func testSearchUsersSuccess() {
        // Given
        let expectViewModel: SearchUserModel = UsersMockData.searchUsersSuccessResponse()!
        worker.isSearchUsersSuccess = true
        // When
        interactor.searchUsers(request: Users.SearchUsers.Request(userName: "ph4"))
        // Then
        XCTAssertEqual(presenter.usersSearch, expectViewModel)
    }
    
    func testSearchUsersFail() {
        // Given
        let expectViewModel: CommonError = UsersMockData.failResponse()!
        worker.isSearchUsersSuccess = false
        // When
        interactor.searchUsers(request: Users.SearchUsers.Request(userName: "ph4"))
        // Then
        XCTAssertEqual(presenter.errorResponse, expectViewModel)
    }
    
    func testFavoriteUsersSuccess() {
        // Given
        var expectViewModel: [UserModel] = UsersMockData.fetchUsersSuccessResponse()!
        expectViewModel[0].isFav = true
        // When
        interactor.favoriteUser(users: expectViewModel, isFav: true, selecedId: 1)
        // Then
        XCTAssertEqual(presenter.usersFavorite, expectViewModel)
    }
    
    func testUnFavoriteUsersSuccess() {
        // Given
        var expectViewModel: [UserModel] = UsersMockData.fetchUsersSuccessResponse()!
        expectViewModel[0].isFav = false
        // When
        interactor.favoriteUser(users: expectViewModel, isFav: false, selecedId: 1)
        // Then
        XCTAssertEqual(presenter.usersFavorite, expectViewModel)
    }
}
