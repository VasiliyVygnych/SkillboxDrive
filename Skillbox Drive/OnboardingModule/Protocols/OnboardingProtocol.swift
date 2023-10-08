//
//  OnboardingProtocol.swift
//  Skillbox Drive
//
//  Created by maryana sorokina on 07.10.2023.
//

import UIKit

protocol OnboardingProtocol: AnyObject {
    func dismiss()
    func secondScreen()
    func threeScreen()
    func openEntrance()
}

protocol OnboardingRouter {
    func secondScreen()
    func threeScreen()
    func makeRootView() -> UIViewController
}
