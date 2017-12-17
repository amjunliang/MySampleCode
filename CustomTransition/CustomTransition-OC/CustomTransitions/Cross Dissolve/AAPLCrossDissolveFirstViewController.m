/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
  Abstract:
 The initial view controller for the Cross Dissolve demo.
 */
#import "AAPLCrossDissolveFirstViewController.h"
#import "AAPLCrossDissolveTransitionAnimator.h"
@interface AAPLCrossDissolveFirstViewController() <UIViewControllerTransitioningDelegate>
@end
@implementation AAPLCrossDissolveFirstViewController
- (IBAction)presentWithCustomTransitionAction:(id)sender
{
     UIViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    secondViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    secondViewController.transitioningDelegate = self;
     [self presentViewController:secondViewController animated:YES completion:NULL];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [AAPLCrossDissolveTransitionAnimator new];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [AAPLCrossDissolveTransitionAnimator new];
}
@end
