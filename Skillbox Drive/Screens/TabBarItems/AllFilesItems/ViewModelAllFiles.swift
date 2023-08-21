//
//  ViewModelAllFiles.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//
import Foundation

// MARK: - protocol ViewModelAllFilesProtocol
protocol RouterAllFilesProtocol: AnyObject {
    func dismiss()
    func dismissAuthorization()
}
protocol ViewModelAllFilesProtocol: AnyObject {
    var updateView: (() -> Void)? { get set }
    var dataCell: Box<AllFilesDisk?> { get set }
    var numberOfSection: Int { get }
    var numberOfRowSection: (_ section: Int) -> Int { get }
}
// MARK: - class ViewModelAllFiles
final class ViewModelAllFiles: RouterAllFilesProtocol {
// MARK: - Router
    typealias Routes = Closable & RouterWebView & RouterWebView
    private var router: Routes
    init(router: Routes) {
        self.router = router
    }
//MARK: - router methods
    func dismiss() {
        router.close()
    }
    func dismissAuthorization() {
        router.openAuthorization()
    }
}

// MARK: - class ViewModelAllFilesModel
final class AllFilesModel: ViewModelAllFilesProtocol {
    var dataCell: Box<AllFilesDisk?> = Box(nil)
    var updateView: (() -> Void)?
    var numberOfSection: Int {
        return 1
    }
    lazy var numberOfRowSection: (Int) -> Int = getNumberOfRowSection
    private func getNumberOfRowSection(_ section: Int) -> Int {
        return dataCell.value??.embedded.items.count ?? 0
    }
}
