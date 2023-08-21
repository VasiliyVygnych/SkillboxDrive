//
//  OnboardingRouter.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

protocol OnboardingRouter {
    func openScreen3_2()
    func openScreen3_3()
    func makeRootView() -> UIViewController
}
extension OnboardingRouter where Self: Router {
// MARK: - func makeRootView
    func makeRootView() -> UIViewController {
        UserDefaults.standard.bool(forKey: UserDefaultsKey.saveAuth)
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = ViewModelOnboarding(router: router)
        let viewController = ViewsOnboarding3_1(viewModel: viewModel)
        router.root = viewController
        let navigation = UINavigationController(rootViewController: viewController)
        return navigation
    }
// MARK: - func openScreen3_2
    func openScreen3_2(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = ViewModelOnboarding(router: router)
        let viewController = ViewsOnboarding3_2(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
// MARK: - func openScreen3_3
    func openScreen3_3(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = ViewModelOnboarding(router: router)
        let viewController = ViewsOnboarding3_3(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
// MARK: - func transition screen
    func openScreen3_2() {
        openScreen3_2(with: Animated(animatedTransition: AnimatedTransition()))
    }
    func openScreen3_3() {
        openScreen3_3(with: Animated(animatedTransition: AnimatedTransition()))
    }
}
extension DefaultRouter: OnboardingRouter {}

