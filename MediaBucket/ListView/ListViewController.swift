//
//  ListViewController.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 18/08/22.
//

import Foundation
import UIKit

final class ListViewController: UIViewController {
    let tableView = UITableView()
    
    override func viewDidLoad() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        tableView.backgroundColor = .red
        self.title = "Test"
    }
}
