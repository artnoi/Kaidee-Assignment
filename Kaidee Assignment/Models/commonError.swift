import Foundation

// MARK: - CommonError

struct CommonError: Codable, Error, Equatable {
    var status: Int?
    var error: String?
    
    init(status: Int, error: String) {
        self.status = status
        self.error = error
    }
}
