//
//  MoviesService.swift
//  MoviesApp
//
//  Created by gawin on 29/12/2025.
//

import Foundation

final class MoviesService {
    
    private let networkService = NetworkService()
    private let apiKey = "d81a952979d2d0d5f09793ebbaca5abb"
    
    func searchMovies(query: String, completion: @escaping (Result<[MovieDTO], NetworkError>) -> Void) {
        guard !query.isEmpty else { return }
        
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        
        let urlString =
                """
                https://api.themoviedb.org/3/search/movie\
                ?api_key=\(apiKey)\
                &query=\(queryEncoded)
                """
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        networkService.request(url: url) { (result: Result<MoviesResponseDTO, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
