/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
  Abstract:
 A transition animator that transitions between two view controllers in
  a tab bar controller by sliding both view controllers in a given
  direction.
 */
#import "AAPLSlideTransitionAnimator.h"
@implementation AAPLSlideTransitionAnimator
 - (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge
{
    self = [self init];
    if (self) {
        _targetEdge = targetEdge;
    }
    return self;
}
 - (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}
  - (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
     UIView *containerView = transitionContext.containerView;
    UIView *fromView;
    UIView *toView;
     if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
     CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
      CGVector offset;
    if (self.targetEdge == UIRectEdgeLeft)
        offset = CGVectorMake(-1.f, 0.f);
    else if (self.targetEdge == UIRectEdgeRight)
        offset = CGVectorMake(1.f, 0.f);
    else
        NSAssert(NO, @"targetEdge must be one of UIRectEdgeLeft, or UIRectEdgeRight.");
     fromView.frame = fromFrame;
    toView.frame = CGRectOffset(toFrame, toFrame.size.width * offset.dx * -1,
                                toFrame.size.height * offset.dy * -1);
     [containerView addSubview:toView];
     NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
     [UIView animateWithDuration:transitionDuration animations:^{
        fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width * offset.dx,
                                      fromFrame.size.height * offset.dy);
        toView.frame = toFrame;
     } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
          [transitionContext completeTransition:!wasCancelled];
    }];
}
@end
