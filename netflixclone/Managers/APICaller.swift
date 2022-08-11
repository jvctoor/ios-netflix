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
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_Key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
            
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
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_Key)&query=\(query)") else { return }
            
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
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "https://youtube.googleapis.com/youtube/v3/search?q=\(query)&key=\(Constants.youtubeAPI_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(response.items[0]))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
    
        }
        
        task.resume()
        
    }
    
}
