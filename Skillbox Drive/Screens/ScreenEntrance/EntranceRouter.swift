//
//  EntranceRouter.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

protocol EntranceRouter {
    func openEntrance()
}
extension EntranceRouter where Self: Router {
    func openEntrance(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = ViewModelEntrance(router: router)
        let viewController = ViewControllerEntrance(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
    func openEntrance() {
        openEntrance(with: Animated(animatedTransition: AnimatedTransition()))
    }
}
extension DefaultRouter: EntranceRouter {}
