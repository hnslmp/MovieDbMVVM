//
//  MovieListViewModel.swift
//  movieDbMVVM
//
//  Created by Hansel Matthew on 13/01/23.
//

import Foundation
import RxSwift
import RxCocoa

class MovieListViewModel {
    
    // MARK: - Variables
    var genreSelected: GenreResult?
    private var moviePage = 1
    let obsMovieResult: BehaviorRelay<[MovieResult]> = BehaviorRelay(value: [])
    let obsIsLoading: BehaviorRelay<Bool> = BehaviorRelay(value: true)

    // MARK: - Functions
    func requestApiMovieList() {
        guard let genreSelected = genreSelected else { return }
        ApiManager.shared.getMoviesList(genreId: genreSelected.id, page: moviePage) { [self] result in
            switch result {
            case .success(let movies):
                
                var movieResult = self.obsMovieResult.value
                movieResult.append(contentsOf: movies)
                
                self.obsMovieResult.accept(movieResult)
                self.moviePage += 1
                
                obsIsLoading.accept(false)
                
            case .failure(let error):
                obsIsLoading.accept(false)
                print(error)
            }
        }
    }
}
