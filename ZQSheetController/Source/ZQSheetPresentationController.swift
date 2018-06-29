//
//  ZQSheetPresentationController.swift
//  ZQSheetController
//
//  Created by zhaozq on 2018/6/28.
//  Copyright © 2018年 HYJF. All rights reserved.
//

import UIKit

open class ZQSheetPresentationController: UIPresentationController {

    
    public var backgroundColor = UIColor.white {
        didSet {
            backgroundView.backgroundColor = backgroundColor
        }
    }
    
    public var presentingViewHeight:CGFloat?
    
    private lazy var backgroundView = UIView(frame: .zero)
    private lazy var blurView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .dark))
    
    override open func presentationTransitionWillBegin() {
        if let container = containerView {
            
            backgroundView.alpha = 0
            backgroundView.frame = container.bounds
            blurView.frame = container.bounds
            backgroundView.addSubview(blurView)
            
            container.addSubview(self.presentingViewController.view)
            container.addSubview(backgroundView)
            //container.insertSubview(backgroundView, at: 0)
            
            let tap = UITapGestureRecognizer.init(target: self, action:#selector(tapGestureAction(_:)))
            backgroundView.addGestureRecognizer(tap)
            
            if let coordinator = presentedViewController.transitionCoordinator {
                coordinator.animate(alongsideTransition: { (_) in
                    self.backgroundView.alpha = 0.6
                }, completion: nil)
            }
        }
    }
    
    override open func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            backgroundView.removeFromSuperview()
        }
    }
    
    override open func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
    
    override open func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            backgroundView.removeFromSuperview()
        }
        UIApplication.shared.keyWindow?.addSubview(self.presentingViewController.view)
    }
    
    override open var shouldRemovePresentersView: Bool {
        return false
    }

    override open var frameOfPresentedViewInContainerView: CGRect {
        if let containerBounds = self.containerView?.bounds, let height = presentingViewHeight {
            return CGRect(x: containerBounds.origin.x, y: containerBounds.size.height - height, width: containerBounds.size.width, height: height)
        }
        return (self.containerView?.bounds)!
    }
    
    @objc func tapGestureAction(_ gesture:UITapGestureRecognizer) {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
