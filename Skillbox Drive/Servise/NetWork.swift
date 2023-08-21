//
//  NetWork.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import Foundation
import WebKit

protocol NetWorkProtocol: AnyObject {
//    var request: URLRequest? { get }
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    func downloadingAllFiles(completion: @escaping (AllFilesDisk?) -> Void)
    func showInfoProfile(completion: @escaping (ProfileFiles?) -> Void)
    func showPublishedFiles(completion: @escaping (RecentFiles?) -> Void)
    func showFolder(name: String,
                   completion: @escaping (AllFilesDisk?) -> Void)
    func removeFiles(name: String)
    func shareFiles(sender: UIButton)
    func shareFilesLink(sender: UIButton)
    func renameFile(rename: String, name: String)
    func exitProfile()
    func addingFolder(name: String)
}

final class NetWork: NetWorkProtocol {
// MARK: - Properties
    private let clientID = "136062075b164499ac9ff1da3b2fb23f"
//    private var servis: ServiseProtocol = Servise()
//MARK: - request
//    var request: URLRequest? {
//        guard var urlComponents = URLComponents(string: "https://oauth.yandex.ru/authorize") else { return nil }
//        urlComponents.queryItems = [
//            URLQueryItem(name: "response_type",
//                         value: "token"),
//            URLQueryItem(name: "client_id",
//                         value: "\(clientID)")
//        ]
//        guard let url = urlComponents.url else { return nil }
//        return URLRequest(url: url)
//    }
//MARK: - mhetod webView
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            let targetString = url.absoluteString.replacingOccurrences(of: "#",
                                                                       with: "?")
            guard let components = URLComponents(string: targetString) else { return }
            let getToken = components.queryItems?.first(where: {$0.name == "access_token"})?.value
            UserDefaults.standard.set(getToken,
                                      forKey: UserDefaultsKey.saveToken)
        }
        decisionHandler(.allow)
    }
//MARK: - downloadingAllFiles
    func downloadingAllFiles(completion: @escaping (AllFilesDisk?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
            var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources")
            components?.queryItems = [URLQueryItem(name: "path",
                                                   value: "/")]
            guard let url = components?.url else { return }
            var request = URLRequest(url: url)
            request.setValue("OAuth \(token)",
                             forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) { [weak self ]
                (data, response, error) in
                guard let _ = self,
                      let data = data else { return }
                guard let newFiles = try?
                        JSONDecoder().decode(AllFilesDisk.self,
                                             from: data) else { return }
                let model = newFiles
                completion(model)
            }
            task.resume()
        }
    }
//MARK: - showInfoProfile
    func showInfoProfile(completion: @escaping (ProfileFiles?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
            let components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/")
            guard let url = components?.url else { return }
            var request = URLRequest(url: url)
            request.setValue("OAuth \(token)",
                             forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) { [weak self ]
                (data, response, error) in
                guard let _ = self,
                      let data = data else { return }
                guard let newFiles = try?
                        JSONDecoder().decode(ProfileFiles.self,
                                             from: data) else { return }
                let model = newFiles
                completion(model)
            }
            task.resume()
        }
    }
//MARK: - showPublishedFiles
    func showPublishedFiles(completion: @escaping (RecentFiles?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
            let components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources/last-uploaded")
            guard let url = components?.url else { return }
            var request = URLRequest(url: url)
            request.setValue("OAuth \(token)",
                             forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) { [weak self ]
                (data, response, error) in
                guard let _ = self,
                      let data = data else { return }
                guard let newFiles = try?
                        JSONDecoder().decode(RecentFiles.self,
                                             from: data) else { return }
                let model = newFiles
                completion(model)
            }
            task.resume()
        }
    }
//MARK: - showPublishedFiles
    func showFolder(name: String, completion: @escaping (AllFilesDisk?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
            var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources")
            components?.queryItems = [URLQueryItem(name: "path",
                                                   value: "\(name)")]
            guard let url = components?.url else { return }
            var request = URLRequest(url: url)
            request.setValue("OAuth \(token)",
                             forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) { [weak self ]
                (data, response, error) in
                guard let _ = self,
                      let data = data else { return }
                guard let newFiles = try?
                        JSONDecoder().decode(AllFilesDisk.self,
                                             from: data) else { return }
                let model = newFiles
                completion(model)
            }
            task.resume()
        }
    }
//MARK: - addingFolder
    func addingFolder(name: String) {
        if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
            var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources")
            components?.queryItems = [URLQueryItem(name: "path",
                                                   value: "\(name)"),
                                      URLQueryItem(name: "fields",
                                                   value: "name,_embedded.items.path")
            ]
          guard let url = components?.url else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("OAuth \(token)",
                             forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) { [ weak self ] (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    print("Status: \(response.statusCode)")
                }
            }
            task.resume()
        }
    }
//MARK: - removeFiles
    func removeFiles(name: String) {
        if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
            var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources")
            components?.queryItems = [URLQueryItem(name: "path",
                                                   value: "\(name)"),
                                      URLQueryItem(name: "permanently",
                                                   value: "false")
            ]
          guard let url = components?.url else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("OAuth \(token)",
                             forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) { [ weak self ] (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    print("Status: \(response.statusCode)")
                }
            }
            task.resume()
        }
        print("файл \(name) удален")
    }
    
    
    
//MARK: - shareFiles
    func shareFiles(sender: UIButton) {
        print("alert: поделиться файлом \(sender.tag) ячейки")
    }
//MARK: - shareFilesLink
    func shareFilesLink(sender: UIButton) {
        print("alert: поделиться ссылкой \(sender.tag) ячейки")
    }
//MARK: - renameFile
    func renameFile(rename: String, name: String) {
        
        print("переименовать \(name) в \(rename)")
    }
//MARK: - exitProfile
    func exitProfile() {
        print("exitProfile")
    }
    
    
    
}
