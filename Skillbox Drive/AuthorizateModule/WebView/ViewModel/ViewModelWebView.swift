//
//  ViewModelWebView.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//


final class ViewModelWebView: ViewModelAuthorizateProtocol {
// MARK: - Routes
    typealias Routes = Closable & ItemsTabBarRouter 
    private var router: Routes
    init(router: Routes) {
        self.router = router
    }
    func dismiss() {
        router.close()
    }
    func openTab() {
        router.selectTabBar()
    }
}

