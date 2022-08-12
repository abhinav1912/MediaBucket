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
    
    init(navigationController: UINavigationController, viewController: UIViewController) {
        self.navigationController = navigationController
        self.viewController = viewController
    }

    func start() {
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
