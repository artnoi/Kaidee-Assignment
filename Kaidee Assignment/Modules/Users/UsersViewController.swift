//
//  UsersViewController.swift
//  Kaidee Assignment
//
//  Created by Peerapat Prommaha on 18/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol UsersDisplayLogic: class {
    func displayUsers(_ viewModel: Users.FetchUsers.ViewModel)
    func displayUserFavorite(_ data: [UserModel])
    func displaySearchUsers(_ viewModel: Users.SearchUsers.ViewModel)
}

class UsersViewController: UIViewController, UsersDisplayLogic {
    // MARK: - IBOutlets

    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "Search"
            searchBar.delegate = self
        }
    }
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            let nibCollectionName = UINib(nibName: UserCollectionViewCell.cellIdentifier, bundle: nil)
            collectionView.register(nibCollectionName, forCellWithReuseIdentifier: UserCollectionViewCell.cellIdentifier)
            collectionView.backgroundView = spinner
            spinner.isHidden = true
        }
    }
    
    // MARK: - Properties

    private var dataSource: [UserModel]?
    private let spinner = UIActivityIndicatorView(style: .gray)

    var interactor: UsersBusinessLogic?
    var router: (NSObjectProtocol & UsersRoutingLogic)?
    
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
        let interactorUsers = UsersInteractor()
        let presenter = UsersPresenter()
        let routerUsers = UsersRouter()
        viewController.interactor = interactorUsers
        viewController.router = routerUsers
        interactorUsers.presenter = presenter
        presenter.viewController = viewController
        routerUsers.viewController = viewController
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showIndicator()
        interactor?.fetchUsers()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        navigationItem.titleView = searchBar
    }
    
    private func showErrorDialog(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showIndicator() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    private func hideIndicator() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    // MARK: - UsersDisplayLogic

    func displayUsers(_ viewModel: Users.FetchUsers.ViewModel) {
        hideIndicator()
        switch viewModel.content {
        case .success(let data):
            dataSource = data
            collectionView.reloadData()
        case .failure(let error):
            showErrorDialog(message: error.localizedDescription)
        }
    }
    
    func displaySearchUsers(_ viewModel: Users.SearchUsers.ViewModel) {
        hideIndicator()
        switch viewModel.content {
        case .success(let data):
            dataSource = data.items
            collectionView.reloadData()
        case .failure(let error):
            showErrorDialog(message: error.localizedDescription)
        }
    }
    
    func displayUserFavorite(_ data: [UserModel]) {
        dataSource = data
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension UsersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.cellIdentifier, for: indexPath) as? UserCollectionViewCell, let data = dataSource?[indexPath.row] {
            cell.delegate = self
            cell.setUserCollectionViewCell(data)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth, height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.endEditing(true)
        if let user = dataSource?[indexPath.row] {
            router?.routeToUserRepositories(user: user)
        }
    }
}

// MARK: - UserCollectionViewCellDelegate

extension UsersViewController: UserCollectionViewCellDelegate {
    func favoriteUser(id: Int, isFav: Bool) {
        searchBar.endEditing(true)
        if let data = dataSource {
            interactor?.favoriteUser(users: data, isFav: isFav, selecedId: id)
        }
    }
}

// MARK: - UISearchBarDelegate
extension UsersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showIndicator()
        searchBar.endEditing(true)
        if let userName = searchBar.text, !(userName.isEmpty) {
            self.interactor?.searchUsers(request: Users.SearchUsers.Request(userName: userName))
        } else {
            self.interactor?.fetchUsers()
        }
    }
}
