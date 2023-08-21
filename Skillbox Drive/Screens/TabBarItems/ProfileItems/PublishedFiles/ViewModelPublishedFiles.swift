//
//  ViewModelPublishedFiles.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import Foundation

// MARK: - protocol Router
protocol PublishedFilesProtocol: AnyObject {
    func dismiss()
    func nextScreen()
}
// MARK: - protocol ViewModel
protocol ViewModelPublishedFilesProtocol: AnyObject {
    var dataCell: Box<RecentFiles?> { get set }
    var numberOfSection: Int { get }
    var numberOfRowSection: (_ section: Int) -> Int { get }
}

final class PublishedFiles: PublishedFilesProtocol {
    typealias Routes = EntranceRouter & Closable //& следующий экран
    private var router: Routes
    init(router: Routes) {
        self.router = router
    }
    func dismiss() {
        router.close()
    }
    func nextScreen() {
        //router.
    }
}
// MARK: - class ViewModelAllFilesModel
final class PublishedFilesModel: ViewModelPublishedFilesProtocol {
    var dataCell: Box<RecentFiles?> = Box(nil)
    var numberOfSection: Int {
        return 1
    }
    lazy var numberOfRowSection: (Int) -> Int = getNumberOfRowSection
    private func getNumberOfRowSection(_ section: Int) -> Int {
        return dataCell.value??.items?.count ?? 0
    }
}
