//
//  UsersModels.swift
//  Kaidee Assignment
//
//  Created by Peerapat Prommaha on 18/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
import Moya
import UIKit

enum Users {
    // MARK: - Models

    enum FetchUsers {
        struct Request {}

        struct Response {
            let result: Result<[UserModel]?, CommonError>
        }

        struct ViewModel {
            let content: Result<[UserModel], CommonError>
        }
    }

    enum SearchUsers {
        struct Request {
            let userName: String
        }

        struct Response {
            let result: Result<SearchUserModel?, CommonError>
        }

        struct ViewModel {
            let content: Result<SearchUserModel, CommonError>
        }
    }
}
