//
//  UserRepositoriesPresenter.swift
//  Kaidee Assignment
//
//  Created by Peerapat Prommaha on 21/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol UserRepositoriesPresentationLogic {
    func presentUserRepositories(response: UserRepositories.FetchUserRepositories.Response)
}

class UserRepositoriesPresenter: UserRepositoriesPresentationLogic {
    // MARK: - Properties

    weak var viewController: UserRepositoriesDisplayLogic?

    // MARK: - UserRepositoriesPresentationLogic

    func presentUserRepositories(response: UserRepositories.FetchUserRepositories.Response) {
        switch response.result {
        case .success(let result):
            if let data = result {
                let viewModel = UserRepositories.FetchUserRepositories.ViewModel(content: .success(data))
                viewController?.displayUserRepositories(viewModel)
            } else {
                let viewModel = UserRepositories.FetchUserRepositories.ViewModel(content: .failure(CommonError(status: 404, error: "Not Found")))
                viewController?.displayUserRepositories(viewModel)
            }
        case .failure(let error):
            let viewModel = UserRepositories.FetchUserRepositories.ViewModel(content: .failure(error))
            viewController?.displayUserRepositories(viewModel)
        }
    }
}
