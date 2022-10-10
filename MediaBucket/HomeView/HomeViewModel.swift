//
//  HomeViewModel.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 13/08/22.
//

import Foundation

final class HomeViewModel {
    
    private var sections: [HomeViewSection] = [
        HomeViewSection(title: nil, folders: [
            HomeViewItem(title: "All items", image: nil, description: nil)
        ]),
        HomeViewSection(title: "iCloud", folders: [
            HomeViewItem(title: "Music", image: nil, description: nil),
            HomeViewItem(title: "Videos", image: nil, description: nil),
            HomeViewItem(title: "Books", image: nil, description: nil),
            HomeViewItem(title: "News", image: nil, description: nil)
        ]),
        HomeViewSection(title: "Recent items", folders: [])
    ]
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        return sections[section].folders.count
    }
    
    func getTitleFor(_ section: Int) -> String? {
        return sections[section].title
    }
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> HomeViewItem {
        return sections[indexPath.section].folders[indexPath.row]
    }

    func folderNameIsAvailable(_ name: String) -> Bool {
        // TODO: Optimise this check
        for section in self.sections {
            for folder in section.folders {
                if folder.title == name {
                    return false
                }
            }
        }
        return true
    }
}
