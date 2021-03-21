import Alamofire
import Foundation
import Moya
import UIKit

enum UserServices {
    case getUsers
    case getUserRepositories(userName: String)
    case searchUsers(userName: String)
}

// MARK: - TargetType Protocol Implementation

extension UserServices: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getUserRepositories(let userName):
            return "/users/\(userName)/repos"
        case .searchUsers:
            return "/search/users"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getUsers, .getUserRepositories, .searchUsers:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getUsers, .getUserRepositories:
            return .requestPlain
        case .searchUsers(let userName):
            return .requestParameters(parameters: ["q": userName], encoding: Alamofire.URLEncoding.default)
        }
    }

    var sampleData: Data {
        switch self {
        case .getUsers:
            guard let url = Bundle.main.url(forResource: "users", withExtension: "json"),
                  let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        case .getUserRepositories:
            guard let url = Bundle.main.url(forResource: "UserRepositories", withExtension: "json"),
                  let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        case .searchUsers:
            guard let url = Bundle.main.url(forResource: "SearchUsers", withExtension: "json"),
                  let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }

    var failsOnEmptyData: Bool {
        return false
    }
}

// MARK: - Helpers

private extension String {
    var utf8Encoded: Data {
        if let data = data(using: .utf8) {
            return data
        }
        return Data()
    }
}

extension UserServices: CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy {
        switch self {
        case .getUsers, .getUserRepositories, .searchUsers:
            return .reloadIgnoringCacheData
        }
    }
}

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        }

        return request
    }
}
