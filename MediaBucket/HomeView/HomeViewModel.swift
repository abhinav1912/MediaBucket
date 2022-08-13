//
//  HomeViewModel.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 13/08/22.
//

import Foundation

final class HomeViewModel {
    private var items: [HomeViewItem] = [
        HomeViewItem(title: "Music", image: nil, description: nil),
        HomeViewItem(title: "Books", image: nil, description: nil)
    ]

    func numberOfItemsIn(section: Int) -> Int {
        return self.items.count
    }
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> HomeViewItem {
        return items[indexPath.row]
    }
}
