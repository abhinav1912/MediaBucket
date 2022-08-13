//
//  ViewController.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 11/08/22.
//

import UIKit

final class HomeViewController: UIViewController {
    private var collectionView: UICollectionView
    
    init() {
        let layout = UICollectionViewLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.collectionView)
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
}

