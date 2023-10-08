//
//  ProfileModuleProtocols.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 08.10.2023.
//

import Foundation

protocol RouterProfile {
    func openProfile()
}

protocol ViewModelProfilInputProtocol: AnyObject {
    func dismiss()
    func publishedFiles()
    func noPublishedFiles()
    func exit()
    
    func viewWillAppear()
    var dataCell: Box<ProfileFiles> { get set }
    
    
    
    var usedSpace: Double { get }
    var totalSpace: Double { get }
    var freeSpace: Double { get }
    var occupiedSpace: Double { get }
}



protocol ViewModelProfilOutputProtocol: AnyObject {
    
//    var usedSpace: Double { get }
//    var totalSpace: Double { get }
//    var freeSpace: Double { get }
//    var occupiedSpace: Double { get }
//    
}

