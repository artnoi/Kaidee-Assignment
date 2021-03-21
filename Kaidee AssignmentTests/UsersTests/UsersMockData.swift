import Foundation
@testable import Kaidee_Assignment

struct UsersMockData {
    static func fetchUsersSuccessResponse() -> [UserModel]? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "Users",
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try JSONDecoder().decode([UserModel].self,
                                                           from: jsonData)
                return decodedData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    static func fetchUsersEmptyResponse() -> [UserModel]? {
        let data: [String : Any] = [:]
        do {
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: .prettyPrinted
            )
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let result = try decoder.decode([UserModel].self, from: jsonData)
            return result
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static func failResponse() -> CommonError? {
        let data: [String : Any] = [
                        "status": 404,
                        "message": "Not Found"]
        do {
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: .prettyPrinted
            )
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let result = try decoder.decode(CommonError.self, from: jsonData)
            return result
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static func searchUsersSuccessResponse() -> SearchUserModel? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "SearchUsers",
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(SearchUserModel.self,
                                                           from: jsonData)
                return decodedData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    static func searchUsersEmptyResponse() -> SearchUserModel? {
        let data: [String : Any] = [:]
        do {
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: .prettyPrinted
            )
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let result = try decoder.decode(SearchUserModel.self, from: jsonData)
            return result
        } catch {
            print(error)
        }
        
        return nil
    }
}
