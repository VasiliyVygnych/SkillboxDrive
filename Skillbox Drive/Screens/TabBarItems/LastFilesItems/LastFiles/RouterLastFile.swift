//
//  RouterLastFile.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

protocol RouterLastFile {
    func openLastFile()
}
extension RouterLastFile where Self: Router {
    func openLastFile(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModelRouter = ViewModelLastFiles(router: router)
        let viewController = ViewControllerLastFiles(viewModelRouter: viewModelRouter)
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

