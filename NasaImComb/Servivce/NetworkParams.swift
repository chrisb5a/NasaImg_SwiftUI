//
//  NetworkParams.swift
//  NasaImComb
//
//  Created by CHRISTIAN BEYNIS on 8/22/22.
//

import Foundation

enum NetworkParams {

    case NasaList(start_date: String, end_date: String)
    case NasaImage(path: String)

    
//    "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=2022-01-01&end_date=2022-06-05"
    
    
    
    var url: URL? {
        switch self {
        case .NasaList(start_date: let start_date, end_date: let end_date):
            guard var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod") else { return nil }
            
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "api_key", value: "DEMO_KEY"))
            queryItems.append(URLQueryItem(name: "start_date", value: "\(start_date)"))
            queryItems.append(URLQueryItem(name: "end_date", value: "\(end_date)"))
            
            urlComponents.queryItems = queryItems
            
            return urlComponents.url
            
//        case .movieImage(path: let path):
//            return URL(string: "\(path)", relativeTo: URL(string:"https://apod.nasa.gov/apod/image/"))
            
            
            
        case .NasaImage(path: let path): return URL(string: "\(path)")
        }
    }
    
}

