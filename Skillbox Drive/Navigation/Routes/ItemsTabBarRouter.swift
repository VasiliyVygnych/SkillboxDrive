//
//  ItemsTabBarRouter.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

protocol ItemsTabBarRouter {
    func makeProfileist() -> UIViewController
    func makeLastFiles() -> UIViewController
    func makeAllFiles() -> UIViewController
    func makeSelectTabBar() -> UIViewController
    func selectTabBar()
}
extension ItemsTabBarRouter where Self: Router {
//MARK: - makeProfileist
    func makeProfileist() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModelRouter = ViewModelProfile(router: router)
        let viewController = ViewControllerProfile(viewModel: viewModelRouter)
        router.root = viewController
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: nil,
                                             image: UIImage.init(systemName: "person.fill"),
                                             tag: 0)
        return navigation
    }
//MARK: - makeLastFiles
    func makeLastFiles() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModelRouter = ViewModelLastFiles(router: router)
        let viewController = ViewControllerLastFiles(viewModelRouter: viewModelRouter)
        router.root = viewController
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: nil,
                                             image: UIImage.init(systemName: "doc.fill"),
                                             tag: 1)
        return navigation
    }
//MARK: - makeOllFiles
    func makeAllFiles() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = ViewModelAllFiles(router: router)
        let viewController = ViewControllerAllFiles(viewModel: viewModel)
        router.root = viewController
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: nil,
                                             image: UIImage.init(systemName: "archivebox"),
                                             tag: 2)
        return navigation
    }
    //MARK: - makeSelectTabBar
        func makeSelectTabBar() -> UIViewController {
            UserDefaults.standard.bool(forKey: UserDefaultsKey.saveAuth)
            let tabBar = UITabBarController()
            let router = DefaultRouter(rootTransition: ModalTransition())
            tabBar.viewControllers = [router.makeProfileist(),
                                      router.makeLastFiles(),
                                      router.makeAllFiles()]
            tabBar.modalPresentationStyle = .fullScreen
            tabBar.tabBar.backgroundColor = .white
            tabBar.tabBar.tintColor = .blue
            let navigationController = UINavigationController(rootViewController: tabBar)
            return navigationController
        }
//MARK: - selectTabBar
    func selectTabBar(with transition: Transition)  {
        let tabBar = UITabBarController()
        let router = DefaultRouter(rootTransition: ModalTransition())
        tabBar.viewControllers = [router.makeProfileist(),
                                  router.makeLastFiles(),
                                  router.makeAllFiles()]
        tabBar.modalPresentationStyle = .fullScreen
        tabBar.tabBar.backgroundColor = .white
        tabBar.tabBar.tintColor = .blue
        let navigationController = UINavigationController(rootViewController: tabBar)
        router.root = tabBar
        route(to: navigationController,
              as: transition)
    }
    func selectTabBar() {
        selectTabBar(with: Animated(animatedTransition: AnimatedTransition()))
    }
}
extension DefaultRouter: ItemsTabBarRouter {}
