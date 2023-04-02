//
//  NetworkManager.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

import Alamofire
import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkManager {
    class func request<T: Decodable>(url: String, httpMethod: HTTPMethod, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, expecting: T.Type, completion: @escaping (Result<T, Error>, HTTPURLResponse?, Data?, AFError?) -> Void) {
        AF.request(url, method: Alamofire.HTTPMethod(rawValue: httpMethod.rawValue), parameters: parameters, encoding: URLEncoding.default, headers: headers).validate().responseData { response in

            switch response.result {
            case .success(let data):
                do {
                    let decodedObject = try JSONDecoder().decode(expecting, from: data)
                    completion(.success(decodedObject), response.response, data, response.error)
                } catch let error {
                    completion(.failure(error), response.response, data, response.error)
                }
            case .failure(let error):
                completion(.failure(error), response.response, response.data, error)
            }
        }
    }
}
