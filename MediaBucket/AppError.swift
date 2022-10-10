//
//  Errors.swift
//  MediaBucket
//
//  Created by Abhinav Mathur on 10/10/22.
//

import Foundation

enum AppError {
    case invalidFolderName
    case folderNameExists

    private enum TitleConstants {
        static let invalidFolderName = "Invalid folder name"
        static let folderNameExists = "Folder exists"
    }

    private enum DescriptionConstants {
        static let invalidFolderName = "Folder name must have more than 6 characters"
        static let folderNameExists = "The folder name already exists, please choose another name"
    }

    var title: String {
        switch self {
        case .invalidFolderName:
            return TitleConstants.invalidFolderName
        case .folderNameExists:
            return TitleConstants.folderNameExists
        }
    }

    var message: String {
        switch self {
        case .invalidFolderName:
            return DescriptionConstants.invalidFolderName
        case .folderNameExists:
            return DescriptionConstants.folderNameExists
        }
    }
}
