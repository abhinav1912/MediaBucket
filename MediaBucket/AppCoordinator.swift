//
//  NavigationCoordinator.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 12/08/22.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    let window: UIWindow
    var rootViewController: UINavigationController
    private let homeCoordinator: Coordinator
    
    init(window: UIWindow, rootViewController: UINavigationController, homeCoordinator: Coordinator) {
        self.window = window
        self.homeCoordinator = homeCoordinator
        self.rootViewController = rootViewController
        rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        homeCoordinator.start()
    }
}
