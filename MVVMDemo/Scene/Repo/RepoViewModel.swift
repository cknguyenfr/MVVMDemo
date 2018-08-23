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
        let loadMoreTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let selectedTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let repoList: Driver<[RepoModel]>
        let selectedRepo: Driver<Void>
        let isEmptyData: Driver<Bool>
    }
    
    struct RepoModel {
        let repo: Repo
    }
    
    let navigator: RepoNavigator
    let useCase: RepoUsecaseType
    
    func transform(_ input: RepoViewModel.Input) -> RepoViewModel.Output {
        let loadMoreOutput = setupLoadMorePaging(loadTrigger: input.loadTrigger,
                                                 getItems: useCase.getRepoList,
                                                 refreshTrigger: input.reloadTrigger,
                                                 refreshItems: useCase.getRepoList,
                                                 loadMoreTrigger: input.loadMoreTrigger,
                                                 loadMoreItems: useCase.loadMoreRepoList)
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        let repoList = page
            .map {
                return $0.items.map { RepoModel(repo: $0) }
            }
            .asDriverOnErrorJustComplete()
        let selectedRepo = input.selectedTrigger
            .withLatestFrom(repoList) { indexPath, list in
                return list[indexPath.row]
            }
            .mapToVoid()
        let isEmptyData = Driver.combineLatest(repoList, loading)
            .filter { !$0.1 }
            .map { $0.0.isEmpty}
        
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            repoList: repoList,
            selectedRepo: selectedRepo,
            isEmptyData: isEmptyData
        )
    }
}
