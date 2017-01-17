//
//  MovieTransitioner.swift
//  MovieSelector
//
//  Created by David Rothschild on 1/16/17.
//  Copyright © 2017 Dave Rothschild. All rights reserved.
//

import UIKit

class MovieAnimatedTransitioning:NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresentation = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // take from view controller and to view controller to work with later
        // show overlay and dismiss overlay
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        
        let toView = toVC!.view
        
        // add and work with ever thing
        let containerView = transitionContext.containerView
        
        if isPresentation {
            containerView.addSubview(toView!)
            
        }
        // if we are presenting then present
        let animatingVC = isPresentation ? toVC : fromVC
        
        // animate later
        let animatingView = animatingVC!.view
        
        
        let appearedFrame = transitionContext.finalFrame(for: animatingVC!)
        var dismissedFrame = appearedFrame
        
        // dismissed frame is off screen
        dismissedFrame.origin.y += dismissedFrame.size.height
        
        // are we showing or dismissing
        let initialFrame = isPresentation ? dismissedFrame : appearedFrame
        let finalFrame = isPresentation ? appearedFrame : dismissedFrame
        
        
        animatingView?.frame = initialFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 300, initialSpringVelocity: 5, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            animatingView?.frame = finalFrame
            
            if !self.isPresentation {
                animatingView?.alpha = 0
            }
            
        }) { (success:Bool) in
            if !self.isPresentation {
                fromView?.removeFromSuperview()
            }
            
            transitionContext.completeTransition(true)
        }
    }
}

class MovieTransitionDelegate:NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationController = MoviePresentationController(presentedViewController: presented, presenting: presenting)
        
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = MovieAnimatedTransitioning()
        animationController.isPresentation = true
        return animationController
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = MovieAnimatedTransitioning()
        animationController.isPresentation = false
        return animationController
    }
    
    
}
