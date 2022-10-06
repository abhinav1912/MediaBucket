//
//  ViewController.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 11/08/22.
//

import UIKit

protocol HomeViewControllerDelegate: NSObject {
    func didSelect(item: HomeViewItem)
}

final class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private enum Constants {
        static let title = "Folders"
        static let cellIdentifier = "homeCollectionViewCell"
    }
    
    private lazy var collectionView: UITableView = getTableView()
    private let viewModel: HomeViewModel
    weak var delegate: HomeViewControllerDelegate?

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = Constants.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        let backgroundViewConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(backgroundViewConstraints)

        view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .clear
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        let layoutGuide = self.view.safeAreaLayoutGuide
        let constraints = [
            self.collectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        self.view.backgroundColor = .systemGray6
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    // MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let itemViewModel = self.viewModel.itemAtIndexPath(indexPath)
        cell.configureFor(viewModel: itemViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.itemAtIndexPath(indexPath)
        delegate?.didSelect(item: item)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getTitleFor(section)
    }
    
    // MARK: Private Methods
    
    private func getTableView() -> UITableView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        return tableView
    }
    
    @objc private func addButtonTapped() {
        // TODO: Handle tap
    }
}
