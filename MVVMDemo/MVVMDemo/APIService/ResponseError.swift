//
//  ResponseError.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/20/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case noStatusCode
    case invalidData(data: Any)
    
    case unknown(statusCode: Int)
    case notModified // 304
    case invalidRequest // 400
    case unauthorized // 401
    case accessDenied // 403
    case notFound  // 404
    case methodNotAllowed  // 405
    case validate   // 422
    case serverError // 500
    case badGateway // 502
    case serviceUnavailable // 503
    case gatewayTimeout // 504
}
