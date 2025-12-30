//
//  File.swift
//  MoviesApp
//
//  Created by gawin on 29/12/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError
}

final class NetworkService {
    
    func request<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(.serverError))
                return
            }
            
            guard let data else {
                completion(.failure(.serverError))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
