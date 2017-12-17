
#import "AAPLCustomPresentationController.h"
#define CORNER_RADIUS   16.f
@interface AAPLCustomPresentationController () <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) UIView *presentationWrappingView;
@end
@implementation AAPLCustomPresentationController
- (UIView *)presentationWrappingView
{
    if (!_presentationWrappingView)
    {
        _presentationWrappingView = [[UIView alloc] initWithFrame:self.frameOfPresentedViewInContainerView];
        _presentationWrappingView.layer.shadowOpacity = 0.44f;
        _presentationWrappingView.layer.shadowRadius = 13.f;
        _presentationWrappingView.layer.shadowOffset = CGSizeMake(0, -6.f);
        _presentationWrappingView.backgroundColor = [UIColor orangeColor];
        [_presentationWrappingView addSubview:[super presentedView]];
        [super presentedView].frame = self.frameOfPresentedViewInContainerView;
     }
    return _presentationWrappingView;
}
- (UIView *)dimmingView
{
    if (!_dimmingView)
    {
        _dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        _dimmingView.backgroundColor = [UIColor blackColor];
        _dimmingView.opaque = NO;
        _dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
        _dimmingView.alpha = 0.5f;
    }
    return _dimmingView;
}
#pragma mark - # overwrite
- (UIView*)presentedView
{
    return self.presentationWrappingView;
}
- (CGRect)frameOfPresentedViewInContainerView
{
    return CGRectMake(0, 0, 100, 100);
}
- (void)presentationTransitionWillBegin
{
    [self.containerView addSubview:self.dimmingView];
}
- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
     [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
     if (container == self.presentedViewController)
        [self.containerView setNeedsLayout];
}
- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController)
        return ((UIViewController*)container).preferredContentSize;
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}
- (void)containerViewDidLayoutSubviews
{
    self.dimmingView.frame = self.containerView.bounds;
    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
}
- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return [transitionContext isAnimated] ? 0.35 : 0;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
     UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
     BOOL isPresenting = (fromViewController == self.presentingViewController);
     CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromViewController];
    CGRect toViewInitialFrame = [transitionContext initialFrameForViewController:toViewController];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
     [containerView addSubview:toView];
     if (isPresenting) {
        toViewInitialFrame.origin = CGPointMake(CGRectGetMinX(containerView.bounds), CGRectGetMaxY(containerView.bounds));
        toViewInitialFrame.size = toViewFinalFrame.size;
        toView.frame = toViewInitialFrame;
    } else {
        fromViewFinalFrame = CGRectOffset(fromView.frame, 0, CGRectGetHeight(fromView.frame));
    }
     NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
     [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting)
            toView.frame = toViewFinalFrame;
        else
            fromView.frame = fromViewFinalFrame;
     } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}
- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return self;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}
@end
