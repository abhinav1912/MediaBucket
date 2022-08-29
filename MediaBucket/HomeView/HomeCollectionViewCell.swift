//
//  HomeCollectionViewCell.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 13/08/22.
//

import Foundation
import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.titleLabel.text = nil
    }
    
    private func setupUI() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.layer.cornerRadius = 8
        blurEffectView.clipsToBounds = true
        contentView.addSubview(blurEffectView)
        
        let blurViewConstraints  = [
            blurEffectView.widthAnchor.constraint(equalTo: self.widthAnchor),
            blurEffectView.heightAnchor.constraint(equalTo: self.heightAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        NSLayoutConstraint.activate(blurViewConstraints)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(self.titleLabel)
        let constraints = [
            self.titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
        self.layer.cornerRadius = 8
    }
    
    func configureFor(viewModel: HomeViewItem) {
        self.titleLabel.text = viewModel.title
        self.titleLabel.textColor = .white
        self.titleLabel.numberOfLines = .zero
        self.titleLabel.font = self.titleLabel.font.withSize(24)
    }
}
