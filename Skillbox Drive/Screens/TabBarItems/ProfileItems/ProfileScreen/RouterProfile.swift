//
//  RouterProfile.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

protocol RouterProfile {
    func openProfile()
}
extension RouterProfile where Self: Router {
    func openProfile(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModelRouter = ViewModelProfile(router: router)
        let viewController = ViewControllerProfile(viewModelRouter: viewModelRouter)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
    func openProfile() {
        openProfile(with: ModalTransition())
    }
}
extension DefaultRouter: RouterProfile {}

