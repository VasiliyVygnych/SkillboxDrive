//
//  AuthorizateViewController.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//
import Foundation
import WebKit
import SnapKit

final class AuthorizateViewController: UIViewController, WKUIDelegate {
// MARK: - Properties
    weak var delegate: AuthorizateViewControllerDelegate?
    private var viewModel: ViewModelAuthorizate
    private var netWork: NetWorkProtocol = NetWork()
    private var servis: ServiseProtocol = Servise()
    private let webView = WKWebView()
    private let loader = UIActivityIndicatorView()
    private let clientID = "8b115b0df376467b88f6ef06d168597d"
// MARK: - init
    init(viewModel: ViewModelAuthorizate) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        initialLoading()
        DispatchQueue.main.async {
            guard let request = self.request else { return }
            self.webView.load(request)
        }
    }
// MARK: - setupeViews
    private func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
// MARK: - initialLoading
    private func initialLoading() {
        loader.startAnimating()
        view.addSubview(loader)
        loader.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
//MARK: - request var //
    private var request: URLRequest? { // убрать отсюда
        guard var urlComponents = URLComponents(string: "https://oauth.yandex.ru/authorize") else { return nil }
        urlComponents.queryItems = [
            URLQueryItem(name: "response_type",
                         value: "token"),
            URLQueryItem(name: "client_id",
                         value: "\(clientID)")
        ]
        guard let url = urlComponents.url else { return nil }
        return URLRequest(url: url)
    }
}
// MARK: - extension WKNavigationDelegate
extension AuthorizateViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        netWork.webView(webView, decidePolicyFor: navigationAction,
                        decisionHandler: decisionHandler)
        if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.saveToken) {
            Keys.loginKey = true
            delegate?.changesToken(token: token)
            DispatchQueue.main.async {
                self.servis.checkingLoginKey()
                self.loader.stopAnimating()
                self.view.willRemoveSubview(self.loader)
                self.viewModel.openTab()
            }
        }
    }
}
