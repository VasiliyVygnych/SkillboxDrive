//
//  ViewModelPublishedFiles.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import Foundation


final class PublishedFiles: PublishedFilesProtocol {
    
    private let netWork: NetWorkProtocol = NetWork()
    var dataCell: Box<RecentFiles?> = Box(nil)
    
    typealias Routes = InputRouter & Closable //& следующий экран
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
    
    
    
    func viewWillAppear() {
        netWork.showPublishedFiles { [ weak self ] data in
            DispatchQueue.main.async {
                self?.dataCell.value = data
            }
        }
    }

}
