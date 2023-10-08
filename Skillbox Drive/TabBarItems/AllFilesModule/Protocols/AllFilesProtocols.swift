//
//  AllFilesProtocols.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 08.10.2023.
//

import Foundation

protocol RouterAllFiles {
    func openAllFiles()
}

protocol RouterAllFilesProtocol: AnyObject {
    func dismiss()
    func dismissAuthorization()
    
    func viewWillAppear()
    var dataCell: Box<AllFilesDisk?> { get set }

}
