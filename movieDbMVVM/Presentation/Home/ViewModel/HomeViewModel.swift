//
//  HomeViewModel.swift
//  movieDbMVVM
//
//  Created by Hansel Matthew on 13/01/23.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    let obsGenreResult:BehaviorRelay<[GenreResult]> = BehaviorRelay(value: [])
    
    func requestApiGenres() {
        ApiManager.shared.getMoviesGenres { result in
            switch result {
            case .success(let genres):
                self.obsGenreResult.accept(genres)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
