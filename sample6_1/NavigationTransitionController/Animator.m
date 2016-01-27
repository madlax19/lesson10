//
//  Animator.m
//  NavigationTransitionTest
//
//  Created by Chris Eidhof on 9/27/13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import "Animator.h"

@implementation Animator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = toViewController.view;
    UIView *fromView = fromViewController.view;
    UIView *containerView = transitionContext.containerView;
    CGFloat direction = self.reverse ? - 1 : 1;
    CGFloat constant = -0.005;

    toView.layer.anchorPoint = CGPointMake(direction == 1 ? 0 : 1, 0.5);
    fromView.layer.anchorPoint = CGPointMake(direction == 1 ? 1 : 0, 0.5);
    
    CATransform3D viewFromTranform = CATransform3DMakeRotation(direction * M_PI_2, 0.0, 1.0, 0.0);
    CATransform3D viewToTransform = CATransform3DMakeRotation(-direction * M_PI_2, 0.0, 1.0, 0.0);
    viewFromTranform.m34 = constant;
    viewToTransform.m34 = constant;
    
    containerView.transform = CGAffineTransformMakeTranslation(direction * containerView.frame.size.width / 2.0, 0);
    toView.layer.transform = viewToTransform;
    [containerView addSubview:toView];
    
    [UIView animateWithDuration: [self transitionDuration:transitionContext] animations:^{
        containerView.transform = CGAffineTransformMakeTranslation( -direction * containerView.frame.size.width / 2.0, 0);
        fromView.layer.transform = viewFromTranform;
        toView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
        containerView.transform = CGAffineTransformIdentity;
        fromView.layer.transform = CATransform3DIdentity;
        toView.layer.transform = CATransform3DIdentity;
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        
        if ([transitionContext transitionWasCancelled]) {
            [toView removeFromSuperview];
        } else {
            [fromView removeFromSuperview];
        }
        [transitionContext completeTransition: ![transitionContext transitionWasCancelled]];
    }];

}

@end
