//
//  RouterPublishedFilesNoFiles.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 17.07.2023.
//

import UIKit

protocol RouterPublishedFilesNoFiles {
    func openPublishedFilesNoFiles()
}
extension RouterPublishedFilesNoFiles where Self: Router {
    func openPublishedFilesNoFiles(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModelRouter = PublishedFilesNoFiles(router: router)
        let viewController = ViewPublishedFilesNoFiles(viewModelRouter: viewModelRouter)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
    func openPublishedFilesNoFiles() {
        openPublishedFilesNoFiles(with: Animated(animatedTransition: AnimatedTransition()))
    }
}
extension DefaultRouter: RouterPublishedFilesNoFiles {}
