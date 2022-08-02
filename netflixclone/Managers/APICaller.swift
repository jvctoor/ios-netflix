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
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_Key)") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let response = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(response.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
    
        }
        
        task.resume()
        
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_Key)") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let response = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(response.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
    
        }
        
        task.resume()
        
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_Key)&language=en-US&page=1") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let response = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(response.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
    
        }
        
        task.resume()
        
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_Key)&language=en-US&page=1") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let response = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(response.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
    
        }
        
        task.resume()
        
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_Key)&language=en-US&page=1") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let response = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(response.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
    
        }
        
        task.resume()
        
    }
    
}
