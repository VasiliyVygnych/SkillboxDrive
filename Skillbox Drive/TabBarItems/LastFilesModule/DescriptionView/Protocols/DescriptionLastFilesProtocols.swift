//
//  DescriptionLastFilesProtocols.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 08.10.2023.
//

import Foundation

protocol DescriptionViewProtocol: AnyObject {
    func сonfiguresDescriptionView(cell: DescriptionLastFiles,
                                   modelCell: Item)
    
    
    var dataCell: Box<AllFilesDisk?> { get set }
    var numberOfSection: Int { get }
    var numberOfRowSection: (_ section: Int) -> Int { get }
    
    
    func viewWillAppear(name: String)
    
    func test()
}

// MARK: - protocol ViewModelEntranceProtocol
protocol VMForFolderDescriptionProtocol: AnyObject {
    func сonfiguresDescriptionFolder(cell: DescriptionFolder,
                                   modelCell: Item)
    
    var dataCell: Box<AllFilesDisk?> { get set }
    
    func viewWillAppear(name: String)
    
    
    var updateView: (() -> Void)? { get set }
    var numberOfSection: Int { get }
    var numberOfRowSection: (_ section: Int) -> Int { get }
}
