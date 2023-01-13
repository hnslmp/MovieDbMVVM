//
//  HomeViewController.swift
//  movieDbMVVM
//
//  Created by Hansel Matthew on 13/01/23.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - Variables
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel = HomeViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Choose your movie genre"
        
        viewModel.requestApiGenres()
        
        setupObserver()
        setupView()
        
    }
    
    // MARK: - Custom Functions
    func setupObserver() {
        _ = viewModel.obsGenreResult.subscribe(onNext: { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    func setupView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.obsGenreResult.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = viewModel.obsGenreResult.value[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genreSelected = viewModel.obsGenreResult.value[indexPath.row]
        
        let movieListVC = MovieListViewController()
        movieListVC.viewModel.genreSelected = genreSelected
        
        navigationController?.pushViewController(movieListVC, animated: true)
    }
}
