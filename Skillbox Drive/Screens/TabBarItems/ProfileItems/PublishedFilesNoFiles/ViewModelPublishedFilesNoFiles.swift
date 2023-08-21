//
//  ViewModelPublishedFiles.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import Foundation

// MARK: - protocol Router
protocol PublishedFilesNoFilesProtocol: AnyObject {
    func dismiss()
    func publishedFiles()
    func noPublishedFiles()
}
// MARK: - protocol ViewModel
protocol ViewModelPublishedNoFilesProtocol: AnyObject {
    var dataCell: Box<ProfileFiles?> { get set }
}

final class PublishedFilesNoFiles: PublishedFilesNoFilesProtocol {
    typealias Routes = EntranceRouter & Closable & RouterPublishedFiles & RouterPublishedFilesNoFiles
    private var router: Routes
    init(router: Routes) {
        self.router = router
    }
    func dismiss() {
        router.close()
    }
    func publishedFiles() {
        router.openPublishedFiles()
    }
    func noPublishedFiles() {
        router.openPublishedFilesNoFiles()
    }
}
// MARK: - class PublishedNoFilesModel
final class PublishedNoFilesModel: ViewModelPublishedNoFilesProtocol {
    var dataCell: Box<ProfileFiles?> = Box(nil)
}
