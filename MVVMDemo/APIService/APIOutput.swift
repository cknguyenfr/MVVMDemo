//
//  APIOutput.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/21/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//
import ObjectMapper

class APIOutputBase: Mappable {
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {}
}
