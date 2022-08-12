//
//  AppCoordinatorComposer.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 12/08/22.
//

import Foundation
import UIKit

final class AppCoordinatorComposer {
    static func getInstance(for window: UIWindow) -> Coordinator {
        let rootViewController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: rootViewController, viewController: ViewController())
        let appCoordinator = AppCoordinator(window: window, rootViewController: rootViewController, homeCoordinator: homeCoordinator)
        return appCoordinator
    }
}
