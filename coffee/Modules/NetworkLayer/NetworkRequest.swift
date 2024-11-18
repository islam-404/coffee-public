//
//  NetworkRequest.swift
//  NetworkLayer
//
//  Created by islam on 03.11.2024.
//

import Alamofire
//import Models

public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias ParameterEncoding = Alamofire.ParameterEncoding

public protocol NetworkRequest {
    
    associatedtype Response: Decodable & Sendable
    associatedtype CustomError = ServerErrorCustom

    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var isTokenRequired: Bool { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
}

public extension NetworkRequest {

    var baseUrl: String {
        "http://147.78.66.203:3210"
    }

    var headers: HTTPHeaders? { nil }
    var parameters: [String: Any]? { nil }
    
    var encoding: ParameterEncoding { URLEncoding() }
}
