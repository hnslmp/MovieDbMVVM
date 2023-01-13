//
//  MovieListViewController.swift
//  movieDbMVVM
//
//  Created by Hansel Matthew on 13/01/23.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: - Variables
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 144, height: 288)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        return collectionView
    }()
    
    var viewModel = MovieListViewModel()
    var indicatorView = UIActivityIndicatorView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestApiMovieList()
        
        setupTitle()
        setupObserver()
        setupView()
    }
    
    // MARK: - Custom Function
    func setupTitle() {
        if let genreName = viewModel.genreSelected?.name {
            self.title = "Movies based on \(genreName) genre"
        } else {
            self.title = "List of movies"
        }
        
    }
    
    func setupView() {
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(indicatorView)
    }
    
    func setupObserver() {
        _ = viewModel.obsMovieResult.subscribe(onNext: { (_) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
        _ = viewModel.obsIsLoading.subscribe(onNext: { isLoading in
            if isLoading {
                DispatchQueue.main.async {
                    self.indicatorView.startAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                }
            }
        })
    }

}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.obsMovieResult.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .gray
        cell.configure(with: viewModel.obsMovieResult.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.obsMovieResult.value.count - 2 {
            viewModel.requestApiMovieList()
        }
    }
}
