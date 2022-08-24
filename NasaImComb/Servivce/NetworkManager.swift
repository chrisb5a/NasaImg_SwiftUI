//
//  NetworkManager.swift
//  NasaImComb
//
//  Created by CHRISTIAN BEYNIS on 8/22/22.
//

import Foundation
import Combine

protocol NetworkService {
    func getModel<T: Decodable>(url: URL?) -> AnyPublisher<T, NetworkError>
    func getRawData(url: URL?) -> AnyPublisher<Data, NetworkError>
}

class NetworkManager {
    
    let session: URLSession
    let decoder = JSONDecoder()
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
}

extension NetworkManager: NetworkService {
    
    func getModel<T>(url: URL?) -> AnyPublisher<T, NetworkError> where T : Decodable {
        
        guard let url = url else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        return self.session.dataTaskPublisher(for: url)
            .tryMap { map in
                if let httpResponse = map.response as? HTTPURLResponse,
                   !(200..<300).contains(httpResponse.statusCode) {
                    throw NetworkError.badServerResponse(httpResponse.statusCode)
                }
                
                return map.data
            }.decode(type: T.self, decoder: self.decoder)
            .mapError { error in
                return NetworkError.generalError(error)
            }.eraseToAnyPublisher()
        
    }
    
    func getRawData(url: URL?) -> AnyPublisher<Data, NetworkError> {
        
        guard let url = url else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        return self.session.dataTaskPublisher(for: url)
            .tryMap { map in
                if let httpResponse = map.response as? HTTPURLResponse,
                   !(200..<300).contains(httpResponse.statusCode) {
                    throw NetworkError.badServerResponse(httpResponse.statusCode)
                }
                
                return map.data
            }.mapError { error in
                return NetworkError.generalError(error)
            }.eraseToAnyPublisher()
    }
    
}

