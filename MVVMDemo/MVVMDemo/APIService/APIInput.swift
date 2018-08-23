//
//  APIInput.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/20/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import Alamofire
import ObjectMapper

class APIInputBase {
    var headers = [
        "Content-Type":"application/json; charset=utf-8",
        "Accept":"application/json"
    ]
    let urlString: String
    let requestType: HTTPMethod
    var encoding: ParameterEncoding
    let parameters: [String: Any]?
    let requireAccessToken: Bool
    
    init(urlString: String, parameters: [String: Any]?, requestType: HTTPMethod, requireAccessToken: Bool = true) {
        self.urlString = urlString
        self.parameters = parameters
        self.requestType = requestType
        self.encoding = requestType == .get ? URLEncoding.default : JSONEncoding.default
        self.requireAccessToken = requireAccessToken
    }
}
