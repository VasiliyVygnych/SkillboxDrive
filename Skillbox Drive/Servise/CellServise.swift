//
//  CellServise.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 26.07.2023.
//

import UIKit

// MARK: - protocol ServiseProtocol
protocol CellServiseProtocol: AnyObject {
    func сonfiguresFiles(cells: Cells,
                               modelCell: Item)
    func сonfiguresPublishedFiles(cells: Cells,
                               modelCell: Files)
    func clickCell(sender: UIButton, name: String) -> UIAlertController 
    func removeFile(name: String) -> UIAlertController
    func shareFile(sender: UIButton) -> UIAlertController
    func renameFile(name: String) -> UIAlertController
}
// MARK: - class CellServise
class CellServise: UIViewController, CellServiseProtocol {
// MARK: - Properties
    private let servis: ServiseProtocol = Servise()
    private let netWork: NetWorkProtocol = NetWork()
    
// MARK: - сonfiguresFiles
    func сonfiguresFiles(cells: Cells,
                               modelCell: Item) {
        cells.headerLabel.text = modelCell.name
        if let imageUrl = modelCell.preview,
            let url = URL(string: imageUrl) {
            let request = URLRequest(url: url)
//            if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
//                request.setValue("OAuth \(token)",
//                                 forHTTPHeaderField: "Authorization")
                URLSession.shared.dataTask(with: request) { data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cells.imagePreview.image = image
                        }
                    }
                }.resume()
//            }
        } else {
            cells.imagePreview.image = UIImage(named: "Group")
            guard let created = modelCell.created else { return }
                let date = servis.stringToDate(string: created)
                let stringDate = servis.dateToString(date: date)
            cells.infoLabel.text = "\(stringDate)"
        }
        guard let created = modelCell.created else { return }
        guard let size = modelCell.size else { return }
           let date = servis.stringToDate(string: created)
           let stringDate = servis.dateToString(date: date)
        cells.infoLabel.text = "\(size/1024) kb, \(stringDate)"
    }
  
// MARK: - сonfiguresPublishedFiles
    func сonfiguresPublishedFiles(cells: Cells,
                                  modelCell: Files) {
    guard let size = modelCell.size else { return }
    guard let created = modelCell.created else { return }
        let date = servis.stringToDate(string: created)
        let srt = servis.dateToString(date: date)
        cells.headerLabel.text = modelCell.name
        cells.infoLabel.text = "\(size/1024) kb, \(String(describing: srt))"
        if let imageUrl = modelCell.preview,
            let url = URL(string: imageUrl) {
            let request = URLRequest(url: url)
//            if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
//                request.setValue("OAuth \(token)",
//                                    forHTTPHeaderField: "Authorization")
                URLSession.shared.dataTask(with: request) { data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cells.imagePreview.image = image
                        }
                    }
                }.resume()
//            }
        }
    }
// MARK: - clickCell
    func clickCell(sender: UIButton, name: String) -> UIAlertController {
        let alert = UIAlertController(title: "",
                                      message: "\(name)",
                                      preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Отмена".localized(),
                                         style: .cancel)
        let action = UIAlertAction(title: "Убрать публикацию".localized(),
                                   style: .destructive) { (action) in
            print("clickCell for \(sender.tag)")
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
        let popover = alert.popoverPresentationController
        popover?.sourceView = sender
        popover?.sourceRect = sender.bounds
        return alert
    }

// MARK: - remveFile alert
    func removeFile(name: String) -> UIAlertController {
        let alert = UIAlertController(title: "",
                                      message: "Данный файл будет удален".localized(),
                                      preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Отмена".localized(),
                                         style: .cancel)
        let action = UIAlertAction(title: "Убрать публикацию".localized(),
                                   style: .destructive) { (action) in
            self.netWork.removeFiles(name: name)
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
//        let popover = alert.popoverPresentationController
//        popover?.sourceView = sender
//        popover?.sourceRect = sender.bounds
        return alert
    }
// MARK: - shareFile alert
    func shareFile(sender: UIButton) -> UIAlertController {
        let alert = UIAlertController(title: "",
                                      message: "Поделиться".localized(),
                                      preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Отмена".localized(),
                                         style: .cancel)
        let firstAction = UIAlertAction(title: "Ссылкой".localized(),
                                        style: .default) { (action) in
            self.netWork.shareFilesLink(sender: sender)
        }
        let secondAction = UIAlertAction(title: "Файлом".localized(),
                                         style: .default) { (action) in
            self.netWork.shareFiles(sender: sender)
        }
        alert.addAction(cancelAction)
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        let popover = alert.popoverPresentationController
        popover?.sourceView = sender
        popover?.sourceRect = sender.bounds
        return alert
    }
// MARK: - shareFile alert
    func renameFile(name: String) -> UIAlertController {
        let alert = UIAlertController(title: "Переименовать файл".localized(),
                                      message: "Введите новое название файла".localized(),
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена".localized(),
                                         style: .default)
        let action = UIAlertAction(title: "Переименовать".localized(),
                                   style: .cancel) { (action) in
            guard let rename = alert.textFields?.first?.text else { return }
            self.netWork.renameFile(rename: rename, name: name)
        }
        alert.addTextField { rename in
            rename.placeholder = "Новое название".localized()
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
//        let popover = alert.popoverPresentationController
//        popover?.sourceView = sender
//        popover?.sourceRect = sender.bounds
        return alert
    }
}
