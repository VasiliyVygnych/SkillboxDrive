//
//  ViewModelAuthorizate.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

// MARK: - AuthorizateViewControllerDelegate
protocol AuthorizateViewControllerDelegate: AnyObject {
    func changesToken(token: String)
}
// MARK: - ViewModelAllFilesProtocol
protocol ViewModelAuthorizateProtocol: AnyObject {
    func dismiss()
    func openTab()
}
final class ViewModelAuthorizate: ViewModelAuthorizateProtocol {
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

