//
//  RouterProfile.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit


extension RouterProfile where Self: Router {
    func openProfile(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = ViewModelProfile(router: router)
        let viewController = ViewControllerProfile(viewModel: viewModel)
        
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

