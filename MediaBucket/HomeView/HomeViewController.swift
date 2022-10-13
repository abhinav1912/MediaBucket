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
        static let newNoteText = "New Note"
        static let newFolderText = "New Folder"
        static let addFolderText = "Add Folder"
        static let nameForFolderText = "Enter a name for the folder"
        static let folderNameText = "Folder name"
        static let descriptionText = "Description (optional)"
        static let addText = "Add"
        static let cancelText = "Cancel"
        static let okayText = "Okay"
    }
    
    private lazy var tableView: UITableView = getTableView()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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

        view.addSubview(self.tableView)
        self.tableView.backgroundColor = .clear
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        let layoutGuide = self.view.safeAreaLayoutGuide
        let constraints = [
            self.tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
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
        let addNoteAction : UIAction = .init(title: Constants.newNoteText, image: nil, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .mixed, handler: { (action) in
                // TODO: Complete action
        })
        let addFolderAction : UIAction = .init(title: Constants.newFolderText, image: nil, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .mixed, handler: { (action) in
            self.presentAlertToAddFolder()
        })

        let actions = [addNoteAction, addFolderAction]
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: actions)
        return menu
    }

    private func presentAlertToAddFolder() {
        let alert = UIAlertController(title: Constants.addFolderText, message: Constants.nameForFolderText, preferredStyle: .alert)

        alert.addTextField() { textField in
            textField.placeholder = Constants.addFolderText
            textField.keyboardType = .default
        }
        alert.addTextField() { textField in
            textField.placeholder = Constants.descriptionText
            textField.keyboardType = .default
        }

        let actions: [UIAlertAction] = [
            UIAlertAction(title: Constants.addText, style: .default, handler: {_ in
                if let folderName = alert.textFields?[0].text {
                    let description = alert.textFields?[1].text
                    self.addFolderButtonTapped(with: folderName, description: description)
                }
            }),
            UIAlertAction(title: Constants.cancelText, style: .cancel, handler: {_ in })
        ]
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }

    private func addFolderButtonTapped(with name: String, description: String?) {
        if !folderNameIsValid(name) {
            self.presentErrorAlert(for: .invalidFolderName)
        }
        if !viewModel.folderNameIsAvailable(name) {
            self.presentErrorAlert(for: .folderNameExists)
        }
        let newItem = viewModel.createFolder(withName: name, description: description)
        delegate?.didSelect(item: newItem)
    }

    private func presentErrorAlert(for error: AppError) {
        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okayText, style: .default, handler: {_ in
            self.presentAlertToAddFolder()
        }))
        self.present(alert, animated: false)
    }

    private func folderNameIsValid(_ name: String) -> Bool {
        // TODO: Complete validity check
        return true
    }
}
