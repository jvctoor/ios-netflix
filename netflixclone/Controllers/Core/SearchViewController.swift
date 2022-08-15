//
//  SearchViewController.swift
//  netflixclone
//
//  Created by João Victor on 30/06/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles: [Title] = [Title]()
    
    private let discoverTable: UITableView = {
        let discoverTable = UITableView()
        discoverTable.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return discoverTable
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a movie or tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.searchController = searchController
        
        view.addSubview(discoverTable)
        
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        fetchDiscoverMovies()
        
        searchController.searchResultsUpdater = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    private func fetchDiscoverMovies() {
        APICaller.shared.getDiscoverMovies { [weak self] response in
            switch response {
            case .success(let results):
                self?.titles = results
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }

        cell.configurePost(with: TitleViewModel(titleName: titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "Unknown", posterURL: titles[indexPath.row].poster_path!, overview: titles[indexPath.row].overview ?? ""))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_name ?? title.original_title else {
            return
        }
        
        APICaller.shared.getMovie(with: titleName + " trailer") { [weak self] response in
            switch response {
            case .success(let video):
                //let title = self?.titles[indexPath.row]
                
                guard let titleOverview = title.overview else { return }
                
                let model = TitlePreviewViewModel(title: titleName, youtubeView: video, titleOverview: titleOverview)
                self?.presentTitlePreview(with: model)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func presentTitlePreview(with model: TitlePreviewViewModel) {
        DispatchQueue.main.async {
            let vc = TitlePreviewViewController()
            vc.configure(with: model)
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
}
