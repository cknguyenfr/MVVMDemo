//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/20/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import RxDataSources
import NSObject_Rx
import Reusable

class RepoViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var tblRepoList: UITableView!
    var viewModel: RepoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        tblRepoList.do {
            $0.estimatedRowHeight = 80
            $0.rowHeight = UITableViewAutomaticDimension
            $0.register(cellType: RepoCell.self)
        }
        tblRepoList.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }
    
    func bindViewModel() {
        let input = RepoViewModel.Input(
            loadTrigger: Driver.just(())
        )
        let output = viewModel.transform(input)
        output.repoList
            .drive(tblRepoList.rx.items) { tableView, index, repo in
                return tableView.dequeueReusableCell(for: IndexPath(row: index, section: 0), cellType: RepoCell.self).then({
                    if let name = repo.name, let urlString = repo.avatarURLString {
                        $0.fillData(imageUrl: urlString, name: name)
                    }
                })
            }
            .disposed(by: rx.disposeBag)
    }
}

extension RepoViewController: UITableViewDelegate {
}

extension RepoViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
