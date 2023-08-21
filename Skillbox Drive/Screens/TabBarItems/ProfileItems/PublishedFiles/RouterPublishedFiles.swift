//
//  RouterPublishedFiles.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import UIKit

protocol RouterPublishedFiles {
    func openPublishedFiles()
}
extension RouterPublishedFiles where Self: Router {
    func openPublishedFiles(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModelRouter = PublishedFiles(router: router)
        let viewController = ViewPublishedFiles(viewModelRouter: viewModelRouter)
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


