//
//  TransitionAnimator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 02.05.2023.
//

import UIKit

class CustomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        if let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false) {
            snapshot.frame = fromVC.view.frame
            containerView.addSubview(snapshot)
            fromVC.view.isHidden = true
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                snapshot.frame = CGRect(x: -fromVC.view.frame.width, y: 0, width: fromVC.view.frame.width, height: fromVC.view.frame.height)
            }) { (_) in
                fromVC.view.isHidden = false
                snapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            fromVC.view.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
