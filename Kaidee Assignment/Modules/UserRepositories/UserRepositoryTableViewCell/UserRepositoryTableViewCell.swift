//
//  UserRepositoryTableViewCell.swift
//  Kaidee Assignment
//
//  Created by Peerapat Prommaha on 21/3/2564 BE.
//

import UIKit

class UserRepositoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var repoName: UILabel!
    static let cellIdentifier = "UserRepositoryTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUserRepository(_ data: RepositoriesModel) {
        repoName.text = data.fullName
    }
}
