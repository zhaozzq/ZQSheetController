//
//  ZQSheetController.swift
//  ZQSheetController
//
//  Created by zhaozq on 2018/6/28.
//  Copyright © 2018年 HYJF. All rights reserved.
//

import UIKit

open class ZQSheetController: UIViewController {

    //@IBInspectable
    public var backgroundColor: UIColor = UIColor.white
    public var presentingHeight: CGFloat?
    
    public var showAnimation: UIViewControllerAnimatedTransitioning? = ZQSheetShowAnimation()
    public var dismissAnimation: UIViewControllerAnimatedTransitioning? = ZQSheetDismissAnimation()
    
    private var percentDriven: UIPercentDrivenInteractiveTransition?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        config()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        config()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.clear
        let pan = UIPanGestureRecognizer.init(target: self, action:#selector(panGestureAction(_:)))
        self.view .addGestureRecognizer(pan)
    }
    
    @objc func panGestureAction(_ gesture:UIPanGestureRecognizer) {
        
        var height = self.view.bounds.height
        if let h = presentingHeight {
            height = h
        }
        
        let percent = gesture.translation(in: self.view).y / height
        
        switch gesture.state {
        case .began:
    
            self.percentDriven = UIPercentDrivenInteractiveTransition()
            self.dismiss(animated: true, completion: nil)
            break
            
        case .changed:
            percentDriven?.update(percent)
            break
        case .ended, .cancelled:
            percentDriven?.finish()
            percentDriven = nil
            break
        default:
            break
        }
        
    }
    
    private func config() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    public func show(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController, _ animated: Bool = true, _ completion:(() -> Void)? = nil) {
        viewController?.present(self, animated: true, completion: completion)
    }

}


extension ZQSheetController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        let controller = ZQSheetPresentationController(presentedViewController: presented, presenting: presenting)
        controller.backgroundColor = backgroundColor
        controller.presentingViewHeight = presentingHeight
        return controller
    }
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return showAnimation
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimation
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentDriven
    }
}

