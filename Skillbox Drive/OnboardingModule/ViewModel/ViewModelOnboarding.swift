//
//  ViewModelOnboarding.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import Foundation


final class ViewModelOnboarding: OnboardingProtocol {
// MARK: - Routes
    typealias Routes = InputRouter & OnboardingRouter & Closable
    private var router: Routes
    init(router: Routes) {
        self.router = router
    }
    func dismiss() {
        router.close()
    }
    func secondScreen() {
        router.secondScreen()
    }
    func threeScreen() {
        router.threeScreen()
    }
    func openEntrance() {
        router.openEntrance()
    }
}
