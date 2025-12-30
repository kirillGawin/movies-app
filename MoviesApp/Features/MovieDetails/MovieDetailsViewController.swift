//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by gawin on 30/12/2025.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    
    private let movie: MovieDTO
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let overviewLabel = UILabel()
    
    private let favouritesService = FavouritesService()
    private let favouriteButton = UIButton(type: .system)
    
    
    init(movie: MovieDTO) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()
        updateFavouriteButton()
        favouriteButton.addTarget(self, action: #selector(favouriteTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Details"
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 12
        posterImageView.backgroundColor = .secondarySystemBackground
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        overviewLabel.font = .systemFont(ofSize: 16)
        overviewLabel.numberOfLines = 4
        overviewLabel.textColor = .secondaryLabel
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(favouriteButton)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 200),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            favouriteButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 16),
            favouriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func updateFavouriteButton() {
        let isFav = favouritesService.isFavourite(id: movie.id)
        let title = isFav ? "★ Remove from Favourites" : "☆ Add to Favourites"
        favouriteButton.setTitle(title, for: .normal)
    }
    
    private func configure() {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        if let posterURL = movie.posterURL {
            ImageLoader.shared.loadImage(from: posterURL) { [weak self] image in
                self?.posterImageView.image = image
            }
        } else {
            posterImageView.image = UIImage(systemName: "photo")
        }
    }
    
    @objc private func favouriteTapped() {
        if favouritesService.isFavourite(id: movie.id) {
            favouritesService.remove(id: movie.id)
        } else {
            favouritesService.add(movie: movie)
        }
        updateFavouriteButton()
    }
}
