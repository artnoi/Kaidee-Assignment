//
//  UserRepositoriesInteractor.swift
//  Kaidee Assignment
//
//  Created by Peerapat Prommaha on 21/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol UserRepositoriesBusinessLogic {
    func fetchUserRepositories(request: UserRepositories.FetchUserRepositories.Request)
}

class UserRepositoriesInteractor: UserRepositoriesBusinessLogic {
    // MARK: - Properties

    var presenter: UserRepositoriesPresentationLogic?
    var worker: UserRepositoriesWorker?

    // MARK: - Initializer

    init(worker: UserRepositoriesWorker = UserRepositoriesWorker()) {
        self.worker = worker
    }

    // MARK: - UserRepositoriesBusinessLogic
    func fetchUserRepositories(request: UserRepositories.FetchUserRepositories.Request) {
        worker = UserRepositoriesWorker()
        worker?.getUserRepositories(request: request, completion: { [weak self] result in
            let response = UserRepositories.FetchUserRepositories.Response(result: result)
            self?.presenter?.presentUserRepositories(response: response)
        })
    }

}
