//
//  NetworkService.swift
//  VKPosts
//
//  Created by MacBook on 18/05/2019.
//  Copyright © 2019 Зелимхан Эдилов. All rights reserved.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping(Data?, Error?)-> Void)
}

final class NetworkService: Networking {
    
    private let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        let session = URLSession.init(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
        print(url)
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = params.map { URLQueryItem.init(name: $0, value: $1)  }
        
        return components.url!
    }
}
    

