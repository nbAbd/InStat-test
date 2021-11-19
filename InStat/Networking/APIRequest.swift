//
//  APIRequest.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 18/11/21.
//

import Foundation

public enum RequestType: String {
    case GET, POST, DELETE, PUT, PATCH
}

protocol APIRequest {
    var method: RequestType { get }
    var url: URL { get }
    var parameters: [String: Any] { get }
}


extension APIRequest {
    func requestWithBody(params: [Any]? = nil) -> URLRequest {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        var request = getURLRequest(url: url)
        if let params = params {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        } else {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        return request
    }
    
    
    func getURLRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
