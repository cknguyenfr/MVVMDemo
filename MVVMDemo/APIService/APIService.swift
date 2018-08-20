//
//  APIService.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/20/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RxCocoa
import RxAlamofire
import RxSwift

enum APIError: Error {
    case invalidURL(url: String)
    case invalidResponseData(data: Any)
    case error(responseCode: Int, data: Any)
}

class APIService {
    private func _request(_ input: APIInputBase) -> Observable<Any> {
        let manager = Alamofire.SessionManager.default
        return manager.rx
            .request(input.requestType,
                           input.urlString,
                           parameters: input.parameters,
                           encoding: input.encoding,
                           headers: input.headers)
            .flatMap { dataRequest -> Observable<DataResponse<Any>> in
                dataRequest.rx.responseJSON()
            }
            .map { (dataResponse) -> Any in
                return try self.process(dataResponse)
            }
    }
    
    private func process(_ response: DataResponse<Any>) throws -> Any {
        let error: Error
        switch response.result {
        case .success(let value):
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case 200:
                    return value
                case 304:
                    error = ResponseError.notModified
                case 400:
                    error = ResponseError.invalidRequest
                case 401:
                    error = ResponseError.unauthorized
                case 403:
                    error = ResponseError.accessDenied
                case 404:
                    error = ResponseError.notFound
                case 405:
                    error = ResponseError.methodNotAllowed
                case 422:
                    error = ResponseError.validate
                case 500:
                    error = ResponseError.serverError
                case 502:
                    error = ResponseError.badGateway
                case 503:
                    error = ResponseError.serviceUnavailable
                case 504:
                    error = ResponseError.gatewayTimeout
                default:
                    error = ResponseError.unknown(statusCode: statusCode)
                }
            }
            else {
                error = ResponseError.noStatusCode
            }
            print(value)
        case .failure(let e):
            error = e
        }
        throw error
    }
    
    func request<T: Mappable>(_ input: APIInputBase) -> Observable<T> {
        return _request(input)
            .map { data -> T in
                if let json = data as? [String:Any],
                    let item = T(JSON: json) {
                    return item
                } else {
                    throw APIError.invalidResponseData(data: data)
                }
        }
    }
}
