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

        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        let rightButtonMenu = self.getAddButtonMenu()
        rightButton.menu = rightButtonMenu
        rightButton.primaryAction = nil
        self.navigationItem.rightBarButtonItem = rightButton
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

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.text = viewModel.getTitleFor(section)
            view.textLabel?.font = view.textLabel?.font.withSize(16)
        }
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
    
    @objc private func getAddButtonMenu() -> UIMenu {
        let addNoteAction : UIAction = .init(title: "New Note", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .mixed, handler: { (action) in
                // TODO: Complete action
        })
        let addFolderAction : UIAction = .init(title: "New Folder", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .mixed, handler: { (action) in
            self.presentAlertToAddFolder()
        })

        let actions = [addNoteAction, addFolderAction]
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: actions)
        return menu
    }

    private func presentAlertToAddFolder() {
        let alert = UIAlertController(title: "Add Folder", message: "Enter a name for the folder", preferredStyle: .alert)

        alert.addTextField() { textField in
            textField.placeholder = "Folder name"
            textField.keyboardType = .default
        }
        alert.addTextField() { textField in
            textField.placeholder = "Description (optional)"
            textField.keyboardType = .default
        }

        let actions: [UIAlertAction] = [
            UIAlertAction(title: "Add", style: .default, handler: {_ in
                if let folderName = alert.textFields?.first?.text {
                    let description = alert.textFields?[1].text ?? ""
                    self.addFolderButtonTapped(with: folderName, description: description)
                }
            }),
            UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in })
        ]
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }

    private func addFolderButtonTapped(with name: String, description: String) {
        // TODO: Check name validity
    }

    private func presentErrorAlert(for error: AppError) {
        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in }))
    }
}
