//
//  HttpClient.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 13/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import Foundation
import Alamofire

final class HttpClient {
    func request<T: Decodable>(
        _ url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = nil,
        of type: T.Type = T.self,
        interceptor: RequestInterceptor? = nil,
        completionHandler: @escaping(DataResponse<T, AFError>) -> ()
    ) {
#if DEBUG
        print("-------------------------------- NETWORK REQUEST LOG ---------------------------------------")
        print("headers: \(String(describing: headers))")
        print("parameters:\n \(String(describing: parameters ?? [:]))")
#endif
        
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers,
            interceptor: interceptor
        ) { $0.timeoutInterval = 60 }
            .validate()
            .responseDecodable(of: T.self, emptyResponseCodes: [200, 201]) { (response) in
                switch response.result {
                case .success(_):
                    completionHandler(response)
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 500...599:
                            print("Error 500: Internal Server Error")
                        default:
                            print("Error \(statusCode): \(error.localizedDescription)")
                        }
                        completionHandler(response)
                    } else {
                        switch error {
                        case .sessionTaskFailed(let urlError as URLError) where urlError.code == .timedOut:
                            print("Request timeout!")
                        default:
                            print("Request failed with error: \(error.localizedDescription)")
                        }
                        completionHandler(response)
                    }
                }
            }
            .responseString { (response) in
#if DEBUG
                print("-------------------------------- NETWORK RESPONSE LOG ---------------------------------------")
                print("response.request: ---> \(String(describing: response.request))")  // original URL request
                print("status code ---> \(String(describing: response.response?.statusCode))")
                print("response.data: ---> \(response.data?.toPrettyPrinted ?? "")")
#endif
            }
    }
    
    func uploadFile<T: Decodable>(_ url: URLConvertible, file: Data, method: HTTPMethod = .post, headers: HTTPHeaders? = nil, parameters: Parameters? = nil, interceptor: RequestInterceptor? = nil, of type: T.Type = T.self, completionHandler: @escaping(DataResponse<T, AFError>) -> ()) {
        
#if DEBUG
        print("-------------------------------- FILE UPLOAD LOG ---------------------------------------")
        print("headers: \(String(describing: headers))")
        print("parameters:\n \(String(describing: parameters ?? [:]))")
#endif
        let fileName = "\(Date().timeIntervalSince1970).jpg"
        
        AF.upload(multipartFormData: { multipartFormData in
            if let parameters = parameters {
                for (key, value) in parameters {
                    if let data = "\(value)".data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }
            
            multipartFormData.append(file, withName: "file", fileName: fileName, mimeType: "image/jpg")
        }, to: url, method: method, headers: headers, interceptor: interceptor)
        .validate()
        .responseDecodable(of: T.self, emptyResponseCodes: [200, 201]) { response in
            completionHandler(response)
        }
        .responseString { response in
#if DEBUG
            print("-------------------------------- NETWORK RESPONSE LOG ---------------------------------------")
            print("response.request: ---> \(String(describing: response.request))")  // original URL request
            print("status code ---> \(String(describing: response.response?.statusCode))")
            print("response.data: ---> \(response.data?.toPrettyPrinted ?? "")")
#endif
        }
    }
}


