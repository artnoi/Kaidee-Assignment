import UIKit

@objc protocol UserRepositoriesRoutingLogic {
}

class UserRepositoriesRouter: NSObject, UserRepositoriesRoutingLogic {
    // MARK: - Properties

    weak var viewController: UserRepositoriesViewController?
}
