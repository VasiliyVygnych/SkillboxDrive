//
//  LastFilesProtocols.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 08.10.2023.
//

import Foundation

protocol RouterLastFile {
    func openLastFile()
}

protocol RouterlLastFilesProtocol: AnyObject {
    func dismiss()
    func nextScreen()
    
    var dataCell: Box<AllFilesDisk?> { get set }
    func viewWillAppear()
}


