//
//  RepoCell.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/20/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable

class RepoCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var lblRepoName: UILabel!
    @IBOutlet private weak var imvAvatar: UIImageView!
    
    func fillData(imageUrl: String, name: String) {
        lblRepoName.text = name
        if let url = URL(string: imageUrl) {
            imvAvatar.kf.setImage(with: url)
        }
    }
}
