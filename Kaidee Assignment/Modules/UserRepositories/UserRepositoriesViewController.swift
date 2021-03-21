//
//  UserRepositoriesViewController.swift
//  Kaidee Assignment
//
//  Created by Peerapat Prommaha on 21/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol UserRepositoriesDisplayLogic: class {
    func displayUserRepositories(_ viewModel: UserRepositories.FetchUserRepositories.ViewModel)
}

class UserRepositoriesViewController: UIViewController, UserRepositoriesDisplayLogic {
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            let nibName = UINib(nibName: UserRepositoryTableViewCell.cellIdentifier, bundle: nil)
            tableView.register(nibName, forCellReuseIdentifier: UserRepositoryTableViewCell.cellIdentifier)
            tableView.backgroundView = spinner
            spinner.isHidden = true
        }
    }

    // MARK: - Layout Properties
    
    // MARK: - Properties

    var user: UserModel?
    private var dataSource: [RepositoriesModel] = [RepositoriesModel]()
    private let spinner = UIActivityIndicatorView(style: .gray)

    var interactor: UserRepositoriesBusinessLogic?
    var router: (NSObjectProtocol & UserRepositoriesRoutingLogic)?
    
    // MARK: Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactorUserRepositories = UserRepositoriesInteractor()
        let presenter = UserRepositoriesPresenter()
        let routerUserRepositories = UserRepositoriesRouter()
        viewController.interactor = interactorUserRepositories
        viewController.router = routerUserRepositories
        interactorUserRepositories.presenter = presenter
        presenter.viewController = viewController
        routerUserRepositories.viewController = viewController
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = user?.login
        if let user = self.user {
            interactor?.fetchUserRepositories(request: UserRepositories.FetchUserRepositories.Request(userName: user.login ?? ""))
            spinner.isHidden = false
            spinner.startAnimating()
        }
    }
        
    // MARK: - Private Methods
    
    private func showErrorDialog(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UserRepositoriesDisplayLogic

    func displayUserRepositories(_ viewModel: UserRepositories.FetchUserRepositories.ViewModel) {
        spinner.stopAnimating()
        spinner.isHidden = true
        switch viewModel.content {
        case .success(let data):
            dataSource = data
            tableView.reloadData()
        case .failure(let error):
            showErrorDialog(message: error.localizedDescription)
        }
    }
    
    // MARK: - Other section e.g. Local Notifications
}

// MARK: - UITableViewDataSource
extension UserRepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserRepositoryTableViewCell.cellIdentifier, for: indexPath) as? UserRepositoryTableViewCell {
            cell.setUserRepository(dataSource[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
