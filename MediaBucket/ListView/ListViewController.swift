//
//  ListViewController.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 18/08/22.
//

import Foundation
import UIKit

final class ListViewController: UIViewController {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let item: HomeViewItem
    let viewModel: ListViewModel
    
    init(item: HomeViewItem, viewModel: ListViewModel) {
        self.item = item
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = item.title
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "listViewControllerCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemViewModel = self.viewModel.getData()[indexPath.row]
        let cell: UITableViewCell
        if itemViewModel.description != nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "listViewControllerCell")
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "listViewControllerCell")
        }
        var config = cell.defaultContentConfiguration()
        config.text = itemViewModel.title
        config.secondaryText = itemViewModel.description
        cell.accessoryType = .none
        cell.contentConfiguration = config
        return cell
    }
}
