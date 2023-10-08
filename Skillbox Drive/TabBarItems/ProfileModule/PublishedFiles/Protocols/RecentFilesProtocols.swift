//
//  RecentFilesProtocols.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 08.10.2023.
//

import Foundation

protocol RouterPublishedFiles {
    func openPublishedFiles()
}

protocol PublishedFilesProtocol: AnyObject {
    func dismiss()
    func nextScreen()
    
    func viewWillAppear()
    var dataCell: Box<RecentFiles?> { get set }
    
}

