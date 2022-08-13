//
//  HomeViewModel.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 13/08/22.
//

import Foundation

final class HomeViewModel {
    private var items: [HomeViewItem] = []

    func numberOfItemsIn(section: Int) -> Int {
        return 0
    }
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> HomeViewItem {
        return items[indexPath.row]
    }
}
