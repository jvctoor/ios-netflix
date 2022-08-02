//
//  APICaller.swift
//  netflixclone
//
//  Created by João Victor on 30/07/22.
//

import Foundation


enum APIError: Error {
    case failedToGetData
}

class APICaller {
    
    // instância para usarmos todos os métodos que fizermos aqui
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_Key)") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let response = try JSONDecoder().decode(TrendingMoviesReponse.self, from: data)
                completion(.success(response.results))
                
            } catch {
                completion(.failure(error))
            }
    
        }
        
        task.resume()
        
    }
    
}
