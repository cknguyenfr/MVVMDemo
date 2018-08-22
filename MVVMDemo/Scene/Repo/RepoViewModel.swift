//
//  RepoViewModel.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/21/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import RxSwift
import RxCocoa

struct RepoViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let repoList: Driver<[Repo]>
    }
    
    let navigator: RepoNavigator
    let useCase: RepoUsecaseType
    
    func transform(_ input: RepoViewModel.Input) -> RepoViewModel.Output {
        let repoList = input.loadTrigger
            .flatMapLatest{ _ in
                self.useCase.getRepoList().asDriverOnErrorJustComplete()
            }
        return Output(repoList: repoList.asDriver(onErrorJustReturn: [Repo]()))
    }
}
