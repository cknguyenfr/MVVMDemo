//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/20/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet private weak var tblRepoList: UITableView!
    private var refreshControl: UIRefreshControl!
    fileprivate let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblRepoList.register(cellType: RepoCell.self)
    }
}
