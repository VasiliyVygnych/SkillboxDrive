//
//  RouterPublishedFiles.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import UIKit

extension RouterPublishedFiles where Self: Router {
    func openPublishedFiles(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = PublishedFiles(router: router)
        let viewController = ViewPublishedFiles(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
    func openPublishedFiles() {
        openPublishedFiles(with: Animated(animatedTransition: AnimatedTransition()))
        
    }
}
extension DefaultRouter: RouterPublishedFiles {}


