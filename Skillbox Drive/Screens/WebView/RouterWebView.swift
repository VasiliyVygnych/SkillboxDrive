//
//  RouterWebView.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

protocol RouterWebView {
    func openAuthorization()
}
extension RouterWebView where Self: Router {
    func openWebView(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = ViewModelAuthorizate(router: router)
        let viewController = AuthorizateViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
    func openAuthorization() {
        openWebView(with: ModalTransition())
    }
}
extension DefaultRouter: RouterWebView {}
