/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
  Abstract:
 The initial view controller for the Checkerboard demo.
 */
#import "AAPLCheckerboardFirstViewController.h"
#import "AAPLCheckerboardTransitionAnimator.h"
@interface AAPLCheckerboardFirstViewController () <UINavigationControllerDelegate>
@end
@implementation AAPLCheckerboardFirstViewController
 - (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationController.delegate = self;
}
#pragma mark -
#pragma mark UINavigationControllerDelegate
 - (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [AAPLCheckerboardTransitionAnimator new];
}
@end
