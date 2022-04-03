//
//  CustomAnimators.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 01.02.2022.
//

import UIKit

final class PushAnimator: NSObject,
                          UIViewControllerAnimatedTransitioning {
    
    private let animateTime = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        guard destination is PhotosFriend else {

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = transitionContext.containerView.frame
        
        let rotate = CGAffineTransform(rotationAngle: -.pi / 2)
        destination.view.transform = rotate
        
        destination.view.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        destination.view.layer.position = CGPoint(x: transitionContext.containerView.frame.width, y: 0)

        source.view.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        source.view.layer.position = CGPoint(x: transitionContext.containerView.frame.width, y: 0)

        
        UIView.animateKeyframes(
            withDuration: animateTime,
            delay: 0.0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 1.0,
                    animations: {
                        let rotation = CGAffineTransform(rotationAngle: .pi / 2)
                        source.view.transform = rotation
                    })
                
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 1.0){
                        destination.view.transform = .identity
                    }
            },
            completion: { isComplete in
                if isComplete && !transitionContext.transitionWasCancelled {
                    source.view.transform = .identity
                }
                
                transitionContext.completeTransition(isComplete && !transitionContext.transitionWasCancelled)
            })
            return
        }
    }
}



final class PopAnimator: NSObject,
                         UIViewControllerAnimatedTransitioning {
    
    private let animateTime = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }

        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = transitionContext.containerView.frame
        
        let rotate = CGAffineTransform(rotationAngle: .pi / 2)
        destination.view.transform = rotate
        
        destination.view.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        destination.view.layer.position = CGPoint(x: transitionContext.containerView.frame.width, y: 0)
        
        source.view.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        source.view.layer.position = CGPoint(x: transitionContext.containerView.frame.width, y: 0)
        
        
        UIView.animateKeyframes(
            withDuration: animateTime,
            delay: 0.0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 1.0,
                    animations: {
                        let rotation = CGAffineTransform(rotationAngle: -.pi / 2)
                        source.view.transform = rotation
                    })
                
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 1.0){
                        destination.view.transform = .identity
                    }
            },
            completion: { isComplete in
                if isComplete && !transitionContext.transitionWasCancelled {
                    source.removeFromParent()
                } else if transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
                
                transitionContext.completeTransition(isComplete && !transitionContext.transitionWasCancelled)
            })
    }
}

final class PopPhoto: NSObject, UIViewControllerAnimatedTransitioning {

    private let animateTime = 0.0

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        animateTime
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let destination = transitionContext.viewController(forKey: .to)
        else { return }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = transitionContext.containerView.frame
        
        destination.view.transform = .identity
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

    }
}

final class PushPhoto: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animateTime = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

    }
}

