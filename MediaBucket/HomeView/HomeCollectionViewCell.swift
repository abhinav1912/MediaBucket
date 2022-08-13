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
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(self.titleLabel)
        let constraints = [
            self.titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            self.titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        self.backgroundColor = .red
    }
    
    func configureFor(viewModel: HomeViewItem) {
        self.titleLabel.text = viewModel.title
        self.titleLabel.textColor = .black
    }
}
