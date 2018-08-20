//
//  Repo.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/20/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class Repo: Mappable {
    var id = 0
    var name: String?
    var fullname: String?
    var urlString: String?
    var starCount = 0
    var folkCount = 0
    var avatarURLString: String?
    
    init() {
        
    }
    
    init(name: String) {
        self.name = name
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullname <- map["full_name"]
        urlString <- map["html_url"]
        starCount <- map["stargazers_count"]
        folkCount <- map["forks"]
        avatarURLString <- map["owner.avatar_url"]
    }
}
