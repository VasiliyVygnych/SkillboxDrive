//
//  ViewModelLastFiles.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//
import Foundation

// MARK: - protocol ViewControllerLastFilesProtocol
protocol RouterlLastFilesProtocol: AnyObject {
    func dismiss()
    func nextScreen()
}
protocol ViewModelLastFilesProtocol: AnyObject {
    var dataCell: Box<AllFilesDisk?> { get set }
    var numberOfSection: Int { get }
    var numberOfRowSection: (_ section: Int) -> Int { get }
}
// MARK: - class ViewModelLastFiles
final class ViewModelLastFiles: RouterlLastFilesProtocol {
    typealias Routes = EntranceRouter & Closable
    private var router: Routes
    init(router: Routes) {
        self.router = router
    }
    func dismiss() {
        router.close()
    }
    func nextScreen() { //переход на следующий экран
//        router.
    }
}
// MARK: - class ViewModelAllFilesModel
final class LastFilesModel: ViewModelLastFilesProtocol {
    var dataCell: Box<AllFilesDisk?> = Box(nil)
    var numberOfSection: Int {
        return 1
    }
    lazy var numberOfRowSection: (Int) -> Int = getNumberOfRowSection
    private func getNumberOfRowSection(_ section: Int) -> Int {
        return dataCell.value??.embedded.items.count ?? 0
    }
}
