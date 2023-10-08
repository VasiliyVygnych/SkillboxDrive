//
//  Model.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import Foundation

//MARK: - ProfileFiles
struct ProfileFiles: Codable {
    let trashSize, totalSpace, usedSpace: Int
    let systemFolders: SystemFolders
    
    enum CodingKeys: String, CodingKey {
        case trashSize = "trash_size"
        case totalSpace = "total_space"
        case usedSpace = "used_space"
        case systemFolders = "system_folders"
    }
}
struct SystemFolders: Codable {
    let applications, downloads: String
}

//MARK: - RecentFiles
struct RecentFiles: Codable {
    let items: [Files]?
}
struct Files: Codable {
    let name: String?
    let preview: String?
    let created: String?
    let size: Int?
}

//MARK: - AllFilesDisk
struct AllFilesDisk: Codable {  
    let embedded: Embedded
    let name: String
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case name
    }
}
struct Embedded: Codable {
    let items: [Item]
}
struct Item: Codable {
    let path: String
    let name: String?
    let preview: String?
    let created: String?
    let size: Int?
}
//MARK: - 








