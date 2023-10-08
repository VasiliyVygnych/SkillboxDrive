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
}

protocol ViewModelLastFilesProtocol: AnyObject {
    var dataCell: Box<AllFilesDisk?> { get set }
    var numberOfSection: Int { get }
    var numberOfRowSection: (_ section: Int) -> Int { get }
}


