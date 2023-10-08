//
//  ViewModelLastFiles.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//
import Foundation


// MARK: - class ViewModelLastFiles
final class ViewModelLastFiles: RouterlLastFilesProtocol {
    
    private let netWork: NetWorkProtocol = NetWork()
    var dataCell: Box<AllFilesDisk?> = Box(nil)
    
    typealias Routes = InputRouter & Closable
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
    
    
    func viewWillAppear() {
        netWork.downloadingAllFiles { [ weak self ] data in
            DispatchQueue.main.async {
                self?.dataCell.value = data
            }
        }
    }
    
   
}
