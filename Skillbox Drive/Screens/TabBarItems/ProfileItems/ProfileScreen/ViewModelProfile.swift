//
//  ViewModelProfile.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//
import Foundation

// MARK: - protocol Router
protocol RouterProfileProtocol: AnyObject {
    func dismiss()
    func publishedFiles()
    func noPublishedFiles()
    func exit()
}
// MARK: - protocol ViewModel
protocol ViewModelProfileProtocol: AnyObject {
    var dataCell: Box<ProfileFiles> { get set }

    
    var usedSpace: Double { get }
    var totalSpace: Double { get }
    var freeSpace: Double { get }
    var occupiedSpace: Double { get }
    
    
    
    
}
// MARK: - class ViewModelProfile
final class ViewModelProfile: RouterProfileProtocol {
    typealias Routes = EntranceRouter
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
}
// MARK: - class ViewModelAllFilesModel
final class ProfileModel: ViewModelProfileProtocol {
    var dataCell: Box<ProfileFiles> = Box(nil)


    
    
    
    
    var usedSpace: Double  {
        return 30.0
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
