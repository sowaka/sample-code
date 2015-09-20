//
//  CustomPresentationController.swift
//  SampleCode
//
//  Created by Takeshi Oogami on 2015/09/18.
//  Copyright © 2015年 jp.bigod. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    
    var overlay: UIView!
    
    override func presentationTransitionWillBegin() {
        let containerView = self.containerView!
        
        overlay = UIView(frame: containerView.bounds)
        overlay.gestureRecognizers = [UITapGestureRecognizer(target: self, action: "overlayDidTouch:")]
        overlay.backgroundColor = UIColor.blackColor()
        overlay.alpha = 0.0
        containerView.insertSubview(self.overlay, atIndex: 0)
        
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({
            [unowned self] context in
            self.overlay.alpha = 0.5
            }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator()?.animateAlongsideTransition({
            [unowned self] context in
            self.overlay.alpha = 0.0
            }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            self.overlay.removeFromSuperview()
        }
    }
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: (parentSize.width / 3) * 2, height: parentSize.height)
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var presentedViewFrame = CGRectZero
        let containerBounds = containerView!.bounds
        presentedViewFrame.size = self.sizeForChildContentContainer(self.presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame.origin.x = containerBounds.size.width - presentedViewFrame.size.width
        presentedViewFrame.origin.y = containerBounds.size.height - presentedViewFrame.size.height
        return presentedViewFrame
    }
    
    override func containerViewWillLayoutSubviews() {
        overlay.frame = containerView!.bounds
        self.presentedView()!.frame = self.frameOfPresentedViewInContainerView()
    }
    
    override func containerViewDidLayoutSubviews() {
    }
    
    func overlayDidTouch(sender: AnyObject) {
        self.presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

class CustomAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresent: Bool
    
    init(isPresent: Bool) {
        self.isPresent = isPresent
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            animatePresentTransition(transitionContext)
        } else {
            animateDissmissalTransition(transitionContext)
        }
    }
    
    func animatePresentTransition(transitionContext: UIViewControllerContextTransitioning) {
        let presenting = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let presented  = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView: UIView! = transitionContext.containerView()
        containerView.insertSubview(presented.view, belowSubview: presenting.view)

        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
            presented.view.frame.origin.x -= containerView.bounds.size.width
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
    
    func animateDissmissalTransition(transitionContext: UIViewControllerContextTransitioning) {
        let presented: UIViewController! = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let containerView: UIView! = transitionContext.containerView()

        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
            presented.view.frame.origin.x = containerView.bounds.size.width
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
    
}
