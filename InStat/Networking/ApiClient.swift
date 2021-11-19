//
//  ApiClient.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 18/11/21.
//

import Foundation
import SystemConfiguration

class ApiClient {
    private static var instance: ApiClient?
    
    class var sharedInstance: ApiClient {
        if instance == nil {
            instance = ApiClient()
        }
        return instance!
    }
    
    func send<T>(for: T.Type = T.self, apiRequest: APIRequest, urlRequest: URLRequest? = nil, completion: @escaping (ResponseResult<T>) -> Void) where T: Codable {
        if ApiClient.isConnectedToNetwork() {
            var request: URLRequest {
                if let urlRequest = urlRequest {
                    return urlRequest
                } else {
                    return apiRequest.requestWithBody()
                }
            }
            #if DEBUG
            Logs.formatRequest(request)
            #endif
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                #if DEBUG
                if let response = response {
                    Logs.formatResponse(response, request: request, method: request.httpMethod, data: data)
                }
                #endif
                
                guard let data = data else {
                    return completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                }
                do {
                    let decoder = JSONDecoder()
                    try completion(.success(decoder.decode(T.self, from: data)))
                } catch let decodingError {
                    completion(.failure(decodingError))
                }
            }.resume()
        }
    }
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
}
