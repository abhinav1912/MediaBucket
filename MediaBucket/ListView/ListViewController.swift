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
    let item: HomeViewItem
    let viewModel: ListViewModel
    
    init(item: HomeViewItem, viewModel: ListViewModel) {
        self.item = item
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = item.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    }
}
