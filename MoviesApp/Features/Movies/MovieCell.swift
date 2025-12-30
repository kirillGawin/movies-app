//
//  MovieCell.swift
//  MoviesApp
//
//  Created by gawin on 29/12/2025.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MovieCell"
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    
    private var currentPosterURL: URL?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        currentPosterURL = nil
    }
    
    func configure(title: String, posterURL: URL?) {
        
        
        titleLabel.text = title
        posterImageView.image = UIImage(systemName: "photo")
        currentPosterURL = posterURL
        
        guard let posterURL else { return }
        
        ImageLoader.shared.loadImage(from: posterURL) { [weak self] image in
            guard self?.currentPosterURL == posterURL else { return }
            self?.posterImageView.image = image
        }
    }
    
    private func setupUI() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = .secondarySystemBackground
        posterImageView.layer.cornerRadius = 12
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [posterImageView, titleLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(title: String) {
        titleLabel.text = title
        // Set posterImageView.image here when you have an image source
    }
}
