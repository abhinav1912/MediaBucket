//
//  HomeCoordinator.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 12/08/22.
//

import Foundation
import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var viewController: UIViewController
    private var listViewCoordinator: ListViewCoordinator
    
    init(navigationController: UINavigationController, viewController: UIViewController, listViewCoordinator: ListViewCoordinator) {
        self.navigationController = navigationController
        self.viewController = viewController
        self.listViewCoordinator = listViewCoordinator
    }

    func start() {
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func didSelect(item: HomeViewItem) {
        self.listViewCoordinator.start(with: item)
    }
}

final class HomeCoordinatorComposer {
    static func getInstance(for navigationController: UINavigationController) -> Coordinator {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        let listViewCoordinator = ListViewCoordinatorImpl(navigationController: navigationController)
        return HomeCoordinator(navigationController: navigationController, viewController: viewController, listViewCoordinator: listViewCoordinator)
    }
}
