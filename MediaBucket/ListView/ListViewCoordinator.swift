//
//  ListViewCoordinator.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 15/08/22.
//

import Foundation
import UIKit

protocol ListViewCoordinator: Coordinator {
    func start(with viewModel: HomeViewModel)
}

final class ListViewCoordinatorImpl: ListViewCoordinator {
    var navigationController: UINavigationController
    private var viewController: UIViewController
    
    init(navigationController: UINavigationController, viewController: UIViewController) {
        self.navigationController = navigationController
        self.viewController = viewController
    }

    func start() {
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func start(with viewModel: HomeViewModel) {
        // TODO: Implementation
    }
}
