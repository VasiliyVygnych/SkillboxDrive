//
//  ViewModelAllFiles.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//
import Foundation

final class ViewModelAllFiles: RouterAllFilesProtocol {
    
    private let netWork: NetWorkProtocol = NetWork()
    var dataCell: Box<AllFilesDisk?> = Box(nil)
    
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
    
    func viewWillAppear() {
        netWork.downloadingAllFiles { [ weak self ] data in
            DispatchQueue.main.async {
                self?.dataCell.value = data
            }
        }
    }
}
