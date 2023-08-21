//
//  Servise.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import UIKit

// MARK: - UserDefaultsKey
enum UserDefaultsKey {
    static var saveToken = "token"
    static var saveAuth = "auth"
}
struct Keys {
    static var loginKey = false
    static var token: String = ""
}

// MARK: - protocol ServiseProtocol
protocol ServiseProtocol: AnyObject {
    func stringToDate(string: String) -> Date
    func dateToString(date: Date) -> String
    func checkingLoginKey()
    func addingFolder(sender: UIButton) -> UIAlertController
}

final class Servise: UIViewController, ServiseProtocol {
// MARK: - properties
    private let netWork: NetWorkProtocol = NetWork()
        
// MARK: - stringToDate
    func stringToDate(string: String) -> Date {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+ss:ss"
        let date = formater.date(from: string)
        guard let date = date else {
            return Date()
        }
        return date
    }
    func dateToString(date: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yy HH:mm"
        let string = formater.string(from: date)
        return string
    }
// MARK: - checkLoginKey
    func checkingLoginKey() {
        if Keys.loginKey == true {
            UserDefaults.standard.set(Keys.loginKey, forKey: UserDefaultsKey.saveAuth)
        } else {
            Keys.loginKey = false
            UserDefaults.standard.set(Keys.loginKey, forKey: UserDefaultsKey.saveAuth)
        }
    }
// MARK: - checkLoginKey
    func addingFolder(sender: UIButton) -> UIAlertController  {
        let alert = UIAlertController(title: "Добавить папку".localized(),
                                      message: "Введите название папки".localized(),
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена".localized(),
                                         style: .default)
        let action = UIAlertAction(title: "Создать".localized(),
                                   style: .cancel) { (action) in
            guard let name = alert.textFields?.first?.text else { return }
            self.netWork.addingFolder(name: name)
        }
        alert.addTextField { name in
            name.placeholder = "Название название".localized()
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
        let popover = alert.popoverPresentationController
        popover?.sourceView = sender
        popover?.sourceRect = sender.bounds
        return alert
    } 
}
// MARK: - extension ViewControllerProfile
extension ViewControllerProfile {
    func exitProfile(sender: UIButton) {
        let alert = UIAlertController(title: "",
                                      message: "Профиль".localized(),
                                      preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Выйти".localized(),
                                   style: .destructive) { (action) in
            self.exitConfirmation(sender: sender)
        }
        let cancelAction = UIAlertAction(title: "Отмена".localized(),
                                         style: .cancel)
        alert.addAction(action)
        alert.addAction(cancelAction)
        let popover = alert.popoverPresentationController
        popover?.sourceView = sender
        popover?.sourceRect = sender.bounds
        present(alert,
                animated: true)
    }
    func exitConfirmation(sender: UIButton) {
        let alert = UIAlertController(title: "Выход".localized(),
                                      message: "Вы уверены, что хотите выйти?".localized(),
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Нет".localized(),
                                          style: .cancel)
        let action = UIAlertAction(title: "Да".localized(),
                                    style: .destructive) { (action) in
             self.netWork.exitProfile()
             Keys.loginKey = false
             self.servis.checkingLoginKey()
             self.viewModelRouter.exit()
      }
         alert.addAction(cancelAction)
         alert.addAction(action)
        let popover = alert.popoverPresentationController
        popover?.sourceView = sender
        popover?.sourceRect = sender.bounds
        present(alert,
                animated: true)
     }
}
