//
//  ViewController.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 11/08/22.
//

import UIKit

final class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private enum Constants {
        static let cellIdentifier = "homeCollectionViewCell"
    }
    private var collectionView: UICollectionView
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .white
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        let layoutGuide = self.view.safeAreaLayoutGuide
        let constraints = [
            self.collectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let itemViewModel = self.viewModel.itemAtIndexPath(indexPath)
        cell.configureFor(viewModel: itemViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right),
            height: 64
        )
    }
}
