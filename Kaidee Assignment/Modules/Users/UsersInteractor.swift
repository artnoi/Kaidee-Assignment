//
//  UsersInteractor.swift
//  Kaidee Assignment
//
//  Created by Peerapat Prommaha on 18/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol UsersBusinessLogic {
    func fetchUsers()
    func favoriteUser(users: [UserModel], isFav: Bool, selecedId: Int)
    func searchUsers(request: Users.SearchUsers.Request)
}

class UsersInteractor: UsersBusinessLogic {
    // MARK: - Properties

    var presenter: UsersPresentationLogic?
    var worker: UsersWorker? = UsersWorker()

    // MARK: - Initializer

    init(worker: UsersWorker = UsersWorker()) {
        self.worker = worker
    }

    // MARK: - UsersBusinessLogic

    func fetchUsers() {
        worker?.getUsers(completion: { [weak self] result in
            let response = Users.FetchUsers.Response(result: result)
            self?.presenter?.presentUsers(response: response)
        })
    }
    
    func favoriteUser(users: [UserModel], isFav: Bool, selecedId: Int) {
        var data: [UserModel] = users
        for index in 0..<data.count where data[index].id == selecedId {
            data[index].isFav = isFav
        }
        presenter?.presentUserFavorite(users: data)
    }
    
    func searchUsers(request: Users.SearchUsers.Request) {
        worker?.searchUsers(request: request, completion: { [weak self] result in
            let response = Users.SearchUsers.Response(result: result)
            self?.presenter?.presentSearchUsers(response: response)
        })
    }
}
