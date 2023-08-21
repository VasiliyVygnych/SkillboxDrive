//
//  ModalTransition.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

final class ModalTransition: Transition {
    func open(_ viewController: UIViewController,
              from: UIViewController,
              completion: (() -> Void)?) {
        from.present(viewController,
                     animated: true,
                     completion: completion)
    }
    func close(_ viewController: UIViewController,
               completion: (() -> Void)?) {
        viewController.dismiss(animated: true,
                               completion: completion)
    }
}
