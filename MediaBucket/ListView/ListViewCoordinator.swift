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

    func start() {
        let vc = ListViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func start(with viewModel: HomeViewItem) {
        // TODO: Implementation
        let vc = ListViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }
}
