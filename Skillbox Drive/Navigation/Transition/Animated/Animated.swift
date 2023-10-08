//
//  Animated.swift
//  Skillbox Drive
//
//  Created by Vasiliy Vygnych on 16.07.2023.
//

import UIKit

final class Animated: NSObject {
    let animatedTransition: AnimatedTransition
    var isAnimated: Bool = true
    init(animatedTransition: AnimatedTransition,
         isAnimated: Bool = true) {
        self.animatedTransition = animatedTransition
        self.isAnimated = isAnimated
    }
}
extension Animated: Transition {
    func open(_ viewController: UIViewController,
              from: UIViewController,
              completion: (() -> Void)?) {
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        from.present(viewController,
                     animated: isAnimated,
                     completion: completion)
    }
    func close(_ viewController: UIViewController,
               completion: (() -> Void)?) {
        viewController.dismiss(animated: isAnimated,
                               completion: completion)
    }
}
extension Animated: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source sourse: UIViewController) ->
                            UIViewControllerAnimatedTransitioning? {
        animatedTransition.isPresenting = true
        return animatedTransition
    }
    func animationController(forDismissed dismissed: UIViewController) ->                                               UIViewControllerAnimatedTransitioning? {
        animatedTransition.isPresenting = false
        return animatedTransition
    }
}
