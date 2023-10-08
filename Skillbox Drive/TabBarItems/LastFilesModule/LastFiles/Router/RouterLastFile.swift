//
//  RouterLastFile.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

extension RouterLastFile where Self: Router {
    func openLastFile(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = ViewModelLastFiles(router: router)
        let viewController = ViewControllerLastFiles(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
    func openLastFile() {
        openLastFile(with: ModalTransition())
    }
}
extension DefaultRouter: RouterLastFile {}

