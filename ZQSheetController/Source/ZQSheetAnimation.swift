//
//  ZQSheetAnimation.swift
//  ZQSheetController
//
//  Created by zhaozq on 2018/6/28.
//  Copyright © 2018年 HYJF. All rights reserved.
//

import UIKit

open class ZQSheetShowAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var duration: TimeInterval = 0.5
    public var delay: TimeInterval = 0.0
    public var springWithDamping: CGFloat = 0.8
    public var springVelocity: CGFloat = 0.0
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //toViewController.view  is toView
        guard let toViewController = transitionContext.viewController( forKey: UITransitionContextViewControllerKey.to),
            let toView = transitionContext.view( forKey: UITransitionContextViewKey.to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let startFrame = finalFrame.offsetBy(dx: 0, dy: finalFrame.size.height)
        toView.frame = startFrame
        containerView.addSubview(toView)
        
        //toView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       delay: delay,
                       usingSpringWithDamping: springWithDamping,
                       initialSpringVelocity: springVelocity,
                       options: [.curveLinear, .allowUserInteraction],
                       animations: {
                        toView.frame = finalFrame
        }) { (finished) in
            if finished {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    
}

open class ZQSheetDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var duration: TimeInterval = 0.35
    public var delay: TimeInterval = 0.0
    public var springWithDamping: CGFloat = 0.8
    public var springVelocity: CGFloat = 0.0
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view( forKey: UITransitionContextViewKey.from)
            else {
                return
        }
        
        let containerView = transitionContext.containerView

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       delay: delay,
                       usingSpringWithDamping: springWithDamping,
                       initialSpringVelocity: springVelocity,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                        var finalFrame = fromView.frame
                        finalFrame.origin.y = containerView.bounds.height
                        fromView.frame = finalFrame
                        //fromView.alpha = 0.0
        }) { (finished) in
            //fromView.alpha = 1.0
            if (finished) {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled || !transitionContext.isInteractive)
            }
        }
    }
}
