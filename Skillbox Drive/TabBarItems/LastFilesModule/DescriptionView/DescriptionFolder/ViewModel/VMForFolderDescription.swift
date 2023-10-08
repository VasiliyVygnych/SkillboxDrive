//
//  VMForFolderDescription.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych  on 11.08.2023.
//

import Foundation
import UIKit


final class VMForFolderDescription: UIViewController, VMForFolderDescriptionProtocol {
// MARK: - properties
    private let servis: ServiseProtocol = Servise()
    private let netWork: NetWorkProtocol = NetWork()
    var dataCell: Box<AllFilesDisk?> = Box(nil)
    var updateView: (() -> Void)?
// MARK: - сonfiguresDescriptionFolder
    
    
    
    func viewWillAppear(name: String) {
        netWork.showFolder(name: name, completion: { [ weak self ] data in
            DispatchQueue.main.async {
                self?.dataCell.value = data
            
                
    
            }
        })
    
    }
    
    
    
    
    
    func сonfiguresDescriptionFolder(cell: DescriptionFolder,
                                     modelCell: Item) {
        guard let size = modelCell.size else { return }
        guard let created = modelCell.created else { return }
            let date = servis.stringToDate(string: created)
            let string = servis.dateToString(date: date)
        cell.descriptionLabels.text = "\(size/1024) kb, \(String(describing: string))"
        
        
        
        
        if let imageUrl = modelCell.preview,
            let url = URL(string: imageUrl) {
            let request = URLRequest(url: url)
//            if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
//                request.setValue("OAuth \(token)",
//                                 forHTTPHeaderField: "Authorization")
                URLSession.shared.dataTask(with: request) { data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.imagePreview.image = image
                        }
                    }
                }.resume()
//            }
        }
    }
    
    
    
    
    
    
// MARK: - cells mhetods
    var numberOfSection: Int {
        return 1
    }
    lazy var numberOfRowSection: (Int) -> Int = getNumberOfRowSection
    private func getNumberOfRowSection(_ section: Int) -> Int {
        return dataCell.value??.embedded.items.count ?? 0
    }
}

