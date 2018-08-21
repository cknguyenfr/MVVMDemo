//
//  RepoRequest.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/21/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import ObjectMapper

final class RepoListInput: APIInputBase {
    init() {
        super.init(urlString: URLs.repoList, parameters: nil, requestType: .get)
    }
}

final class RepoListOutput: APIOutputBase {
    private var repos: [Repo]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        repos <- map["items"]
    }
}
