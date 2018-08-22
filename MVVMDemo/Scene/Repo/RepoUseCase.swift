//
//  RepoUseCase.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/21/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import RxSwift

protocol RepoUsecaseType {
    func getRepoList() -> Observable<[Repo]>
}

struct RepoUsecase: RepoUsecaseType {
    func getRepoList() -> Observable<[Repo]> {
        let repositories = RepoRequestRepositories()
        let request = RepoListInput()
        return repositories.getRepoList(input: request)
            .map({ $0.repos })
    }
}
