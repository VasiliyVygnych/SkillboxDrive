//
//  PublishedFilesProtocol.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 08.10.2023.
//

import Foundation

protocol RouterPublishedFilesNoFiles {
    func openPublishedFilesNoFiles()
}

protocol PublishedFilesNoFilesProtocol: AnyObject {
    func dismiss()
    func publishedFiles()
    func noPublishedFiles()
}

protocol ViewModelPublishedNoFilesProtocol: AnyObject {
    var dataCell: Box<ProfileFiles?> { get set }
}
