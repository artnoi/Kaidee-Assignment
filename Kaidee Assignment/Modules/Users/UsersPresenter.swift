//
//  UsersPresenter.swift
//  Kaidee Assignment
//
//  Created by Peerapat Prommaha on 18/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol UsersPresentationLogic {
    func presentUsers(response: Users.FetchUsers.Response)
    func presentUserFavorite(users: [UserModel])
    func presentSearchUsers(response: Users.SearchUsers.Response)
}

class UsersPresenter: UsersPresentationLogic {
    // MARK: - Properties

    weak var viewController: UsersDisplayLogic?

    // MARK: - UsersPresentationLogic

    func presentUsers(response: Users.FetchUsers.Response) {
        switch response.result {
        case .success(let result):
            if let data = result {
                let viewModel = Users.FetchUsers.ViewModel(content: .success(data))
                viewController?.displayUsers(viewModel)
            } else {
                let viewModel = Users.FetchUsers.ViewModel(content: .failure(CommonError(status: 404, error: "Not Found")))
                viewController?.displayUsers(viewModel)
            }
        case .failure(let error):
            let viewModel = Users.FetchUsers.ViewModel(content: .failure(error))
            viewController?.displayUsers(viewModel)
        }
    }
    
    func presentSearchUsers(response: Users.SearchUsers.Response) {
        switch response.result {
        case .success(let result):
            if let data = result {
                let viewModel = Users.SearchUsers.ViewModel(content: .success(data))
                viewController?.displaySearchUsers(viewModel)
            } else {
                let viewModel = Users.SearchUsers.ViewModel(content: .failure(CommonError(status: 404, error: "Not Found")))
                viewController?.displaySearchUsers(viewModel)
            }
        case .failure(let error):
            let viewModel = Users.SearchUsers.ViewModel(content: .failure(error))
            viewController?.displaySearchUsers(viewModel)
        }
    }
    
    func presentUserFavorite(users: [UserModel]) {
        viewController?.displayUserFavorite(users)
    }
}
