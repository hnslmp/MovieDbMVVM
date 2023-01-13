//
//  MovieListCollectionViewCell.swift
//  MovieDbViper
//
//  Created by Hansel Matthew on 21/10/22.
//

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieListCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: MovieResult) {
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)") else { return }
        imageView.sd_setImage(with: imageUrl, completed: nil)
    }
    
}
