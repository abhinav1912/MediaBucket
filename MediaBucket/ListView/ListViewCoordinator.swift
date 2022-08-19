//
//  ListViewCoordinator.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 15/08/22.
//

import Foundation
import UIKit

protocol ListViewCoordinator: Coordinator {
    func start(with viewModel: HomeViewItem)
}

final class ListViewCoordinatorImpl: ListViewCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() { }
    
    func start(with item: HomeViewItem) {
        let viewModel = ListViewModelImpl()
        let vc = ListViewController(item: item, viewModel: viewModel)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
