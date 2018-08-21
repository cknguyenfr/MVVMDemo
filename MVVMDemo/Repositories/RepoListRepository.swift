//
//  RepoListRepository.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/21/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import RxSwift

protocol RepoRequestType {
    func getRepoList(input: RepoListInput) -> Observable<RepoListOutput>
}

final class RepoRequestRepositories: RepoRequestType {
    func getRepoList(input: RepoListInput) -> Observable<RepoListOutput> {
        return APIService.shared.request(input)
    }
}
