//
//  UserRepositoriesModels.swift
//  Kaidee Assignment
//
//  Created by Peerapat Prommaha on 21/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Moya

enum UserRepositories {
    // MARK: - Models

    enum FetchUserRepositories {
        struct Request {
            let userName: String
        }

        struct Response {
            let result: Result<[RepositoriesModel]?, CommonError>
        }

        struct ViewModel {
            let content: Result<[RepositoriesModel], CommonError>
        }
    }
}
