//
//  OnboardingRouter.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit


extension OnboardingRouter where Self: Router {
// MARK: - func makeRootView
    func makeRootView() -> UIViewController {
        UserDefaults.standard.bool(forKey: UserDefaultsKey.saveAuth)
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = ViewModelOnboarding(router: router)
        let viewController = RootOnboardingView(viewModel: viewModel)
        router.root = viewController
        let navigation = UINavigationController(rootViewController: viewController)
        return navigation
    }
// MARK: - func openScreen3_2
    func secondScreen(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = ViewModelOnboarding(router: router)
        let viewController = SecondOnboardingView(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
// MARK: - func openScreen3_3
    func threeScreen(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = ViewModelOnboarding(router: router)
        let viewController = ThreeOnboardingView(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        route(to: navigationController,
              as: transition)
    }
// MARK: - func transition screen
    func secondScreen() {
        secondScreen(with: Animated(animatedTransition: AnimatedTransition()))
    }
    func threeScreen() {
        threeScreen(with: Animated(animatedTransition: AnimatedTransition()))
    }
}
extension DefaultRouter: OnboardingRouter {}

