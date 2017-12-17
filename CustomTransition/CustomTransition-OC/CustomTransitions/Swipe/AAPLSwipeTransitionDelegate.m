
#import "AAPLSwipeTransitionDelegate.h"
#import "AAPLSwipeTransitionAnimator.h"
#import "AAPLSwipeTransitionInteractionController.h"
@implementation AAPLSwipeTransitionDelegate
        - (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[AAPLSwipeTransitionAnimator alloc] initWithTargetEdge:self.targetEdge];
}
        - (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[AAPLSwipeTransitionAnimator alloc] initWithTargetEdge:self.targetEdge];
}
        - (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
              if (self.gestureRecognizer)
        return [[AAPLSwipeTransitionInteractionController alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    else
        return nil;
}
        - (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
              if (self.gestureRecognizer)
        return [[AAPLSwipeTransitionInteractionController alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    else
        return nil;
}
@end
