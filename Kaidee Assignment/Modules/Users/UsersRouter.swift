import UIKit

protocol UsersRoutingLogic {
    func routeToUserRepositories(user: UserModel)
}

class UsersRouter: NSObject, UsersRoutingLogic {
    // MARK: - Properties

    weak var viewController: UsersViewController?

    // MARK: - Navigation

    func routeToUserRepositories(user: UserModel) {
        let vc = UserRepositoriesViewController()
        vc.user = user
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
