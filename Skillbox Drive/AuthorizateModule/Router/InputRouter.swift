//
//  InputRouter.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit


extension InputRouter where Self: Router {
    func openEntrance(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = AuthorizateViewModel(router: router)
        let viewController = AuthorizateViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
    func openEntrance() {
        openEntrance(with: Animated(animatedTransition: AnimatedTransition()))
    }
}
extension DefaultRouter: InputRouter {}
