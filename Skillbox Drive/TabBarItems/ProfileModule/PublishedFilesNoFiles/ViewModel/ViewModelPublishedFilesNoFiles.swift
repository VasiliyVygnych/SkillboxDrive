//
//  ViewModelPublishedFiles.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import Foundation



final class PublishedFilesNoFiles: PublishedFilesNoFilesProtocol {
    typealias Routes = InputRouter & Closable & RouterPublishedFiles & RouterPublishedFilesNoFiles
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
