//
//  HomeCollectionViewCell.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 13/08/22.
//

import Foundation
import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { }
    
    func configureFor(viewModel: HomeViewItem) {
        var cellConfig = self.defaultContentConfiguration()
        cellConfig.text = viewModel.title
        cellConfig.secondaryText = viewModel.description
        cellConfig.image = viewModel.image
        self.accessoryType = .disclosureIndicator
        self.contentConfiguration = cellConfig
    }
}
