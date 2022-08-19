//
//  ListViewModel.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 20/08/22.
//

import Foundation

protocol ListViewModel {
    func getData() -> [ListItem]
}

final class ListViewModelImpl: ListViewModel {
    func getData() -> [ListItem] {
        return [
            ListItem(title: "Test Item", description: nil, link: nil),
            ListItem(title: "Test Item 2", description: "Test description!", link: nil)
        ]
    }
}
