//
//  ViewModelProfile.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//
import Foundation


final class ViewModelProfile: ViewModelProfilInputProtocol {
    
    let netWork: NetWorkProtocol = NetWork()
    var dataCell: Box<ProfileFiles> = Box(nil)

    
    typealias Routes = InputRouter
                    & Closable
                    & RouterPublishedFilesNoFiles
                    & RouterPublishedFiles
                    & OnboardingRouter
    private var router: Routes
    init(router: Routes) {
        self.router = router
    }
    func exit() {
        router.openEntrance()
    }
    func dismiss() {
        router.close()
    }
    func publishedFiles() {
        router.openPublishedFilesNoFiles()
    }
    func noPublishedFiles() {
        router.openPublishedFiles()
    }
    
    
    
    
    func viewWillAppear() {
        netWork.showInfoProfile { [ weak self ] model in
            DispatchQueue.main.async {
                self?.dataCell.value = model
            }
        }
    }
    
    
    
    var usedSpace: Double  {
        guard let model = dataCell.value?.usedSpace else { return 2 }
//        return 30.0
        return Double(model)
    }
    var totalSpace: Double {
        return 9.97
    }
    var occupiedSpace: Double {
        return 0.03
    }
    var freeSpace: Double {
        return 9.97
    }
    
    
    
    
    
    
}








// MARK: - class ViewModelAllFilesModel
extension ViewModelProfile: ViewModelProfilOutputProtocol {
 


    
}
