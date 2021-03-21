//
//  UserCollectionViewCell.swift
//  Kaidee Assignment
//
//  Created by Peerapat Prommaha on 18/3/2564 BE.
//

import UIKit
import Kingfisher

protocol UserCollectionViewCellDelegate: class {
    func favoriteUser(id: Int, isFav: Bool)
}

class UserCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var userUrl: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    static let cellIdentifier = "UserCollectionViewCell"
    weak var delegate: UserCollectionViewCellDelegate?
    private var isFav: Bool = false
    private var id: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setFavIcon()
    }
    
    func setUserCollectionViewCell(_ data: UserModel) {
        if let url = URL(string: data.avatarUrl ?? "") {
            userImage.kf.indicatorType = .activity
            userImage.kf.setImage(with: url)
        }
        userName.text = data.login
        userUrl.text = data.url
        self.isFav = data.isFav
        self.id = data.id
        setFavIcon()
    }
    
    private func setFavIcon() {
        favoriteButton.setBackgroundImage(self.isFav ? UIImage(named: "ic-fav") : UIImage(named: "ic-unfav"), for: .normal)
    }
    
    @IBAction private func favoriteButtonTapped(_ sender: Any) {
        if let id = self.id {
            self.isFav = !self.isFav
            setFavIcon()
            delegate?.favoriteUser(id: id, isFav: self.isFav )
        }
    }
}
