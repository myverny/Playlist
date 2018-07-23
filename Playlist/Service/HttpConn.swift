//
//  HttpConn.swift
//  Playlist
//
//  Created by dev on 2018. 7. 20..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation

class HttpConn {
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    
    static private var apiKey: String = "AIzaSyDfww5cAC_HtI3bb_J_3pXshmTRcLaVcNM"
    
    static func getVideoInfo(for videoId: String, completion: ((Result<[VideoInfo]>) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.googleapis.com"
        urlComponents.path = "/youtube/v3/videos"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: videoId),
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "fields", value: "items(id,snippet(title),statistics(viewCount))"),
            URLQueryItem(name: "part", value: "snippet,statistics")
        ]
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let container = try decoder.decode(VideoInfoContainer.self, from: jsonData)
                        completion?(.success(container.items))
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let error = NSError(
                        domain: "",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]
                        ) as Error
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
