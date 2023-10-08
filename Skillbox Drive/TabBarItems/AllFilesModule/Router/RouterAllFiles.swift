//
//  RouterAllFiles.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

extension RouterAllFiles where Self: Router {
    func openAllFiles(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = ViewModelAllFiles(router: router)
        let viewController = ViewControllerAllFiles(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
    func openAllFiles() {
        openAllFiles(with: Animated(animatedTransition: AnimatedTransition()))
    }
}
extension DefaultRouter: RouterAllFiles {}
