//
//  UpcomingViewController.swift
//  netflixclone
//
//  Created by João Victor on 30/06/22.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var upcomingTitles: [Title] = [Title]()
    
    private let upcomingTable: UITableView = {
        let upcomingTable = UITableView()
        upcomingTable.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return upcomingTable
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(upcomingTable)
    
        
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcoming()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func fetchUpcoming() {
        APICaller.shared.getUpcomingMovies { [weak self] response in
            switch response {
            case .success(let results):
                self?.upcomingTitles = results
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let upcomingCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        upcomingCell.configurePost(with: TitleViewModel(titleName: upcomingTitles[indexPath.row].original_name ?? upcomingTitles[indexPath.row].original_title ?? "Unknown", posterURL: upcomingTitles[indexPath.row].poster_path!))
        
        return upcomingCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = upcomingTitles[indexPath.row]
        
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


