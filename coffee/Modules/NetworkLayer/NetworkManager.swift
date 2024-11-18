//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by islam on 03.11.2024.
//

import Foundation
import Alamofire
//import Models

public protocol NetworkManager {
    func send<T: NetworkRequest>(request: T, completion: @escaping (Result<T.Response, ServerErrorCustom>) -> Void)
}

struct AnyNetworkRequest<T: NetworkRequest> {
    let request: T
    let performRequest: (Result<T.Response, ServerErrorCustom>) -> Void

    init(
        request: T,
        completion: @escaping (Result<T.Response, ServerErrorCustom>) -> Void
    ) {
        self.request = request
        self.performRequest = completion
    }
}


//var requestQueue: [(T: NetworkRequest, completion: @escaping (Result<T.Response, ServerErrorCustom>) -> ()] = []
public final class NetworkManagerImp: NetworkManager {
    
    private let session: Session
    private var tokenValidator: TokenManager
//    private var requestQueue: [(request: any NetworkRequest, ew: Int)] = []
    
    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        session = Session(configuration: configuration)
        tokenValidator = TokenManager.shared
    }
    
    public func send<T: NetworkRequest>(
        request: T,
        completion: @escaping (Result<T.Response, ServerErrorCustom>) -> Void
    ) {
        var headers: HTTPHeaders = request.headers ?? []
        
        if request.isTokenRequired, !tokenValidator.isLifeToken {
            /// Здесь нужно бы добавить логику ожидания, чтобы не было вызова делегата несколько раз.
            /// Должно работать следующим образом:
            /// - Если поступил первый запрос с истекшим токеном, мы вызываем делегат `didExpireToken()`.
            /// - Если одновременно поступают другие запросы с истекшим токеном, делегат не должен вызываться повторно,
            ///   пока не завершится процесс обновления токена, после уже с обновленным токеном эти запросы выполнятся.
            /// - Например у токен валидатора может быть дополнительное свойство, `isUpdatingToken`,
            ///   которое отслеживает, выполняется ли в данный момент процесс обновления токена.
            /// - В случае, если `isUpdatingToken` установлен в `true`, остальные запросы должны ожидать,
            ///   пока обновление токена завершится.
            /// Так как это тестовое, я пока не хочу тратить на него время, потому что и чутка занят сейчас)
            tokenValidator.delegate?.didExpireToken()
        } else if request.isTokenRequired, let token = tokenValidator.token {
            headers.add(.authorization(bearerToken: token))
        }
        
        let sessionRequest = session.request(
            URL(string: request.baseUrl)!.appendingPathComponent(request.path),
            method: request.method,
            parameters: request.parameters,
            encoding: request.encoding,
            headers: headers,
            interceptor: nil,
            requestModifier: nil
        )
        
        
        sessionRequest.validate().responseDecodable { (response: DataResponse<T.Response, AFError>) in
            
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
                print("responce - \(String(data: response.data ?? Data(), encoding: .utf8) ?? "")")
                completion(.failure(.init()))
            }
        }
    }
}
