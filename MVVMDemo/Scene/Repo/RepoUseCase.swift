//
//  RepoUseCase.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/21/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import RxSwift
import OrderedSet

protocol RepoUsecaseType {
    func getRepoList() -> Observable<PagingInfo<Repo>>
    func loadMoreRepoList(page: Int) -> Observable<PagingInfo<Repo>>
}

struct RepoUsecase: RepoUsecaseType {
    func getRepoList() -> Observable<PagingInfo<Repo>> {
        return loadMoreRepoList(page: 1)
    }
    
    func loadMoreRepoList(page: Int) -> Observable<PagingInfo<Repo>> {
        let repositories = RepoRequestRepositories()
        let request = RepoListInput(page: page, perPage: 10)
        return repositories.getRepoList(input: request)
            .map({ PagingInfo(page: 1, items: OrderedSet<Repo>(sequence: $0.repos))})
    }
}
