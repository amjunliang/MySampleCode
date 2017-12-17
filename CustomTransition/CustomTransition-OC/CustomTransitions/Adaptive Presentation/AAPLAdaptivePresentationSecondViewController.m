/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
  Abstract:
 The second view controller for the Adaptive Presentation demo.
 */
#import "AAPLAdaptivePresentationSecondViewController.h"
#import "AAPLAdaptivePresentationController.h"
@interface AAPLAdaptivePresentationSecondViewController () <UIAdaptivePresentationControllerDelegate>
@end
@implementation AAPLAdaptivePresentationSecondViewController
 - (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismissButtonAction:)];
    self.navigationItem.leftBarButtonItem = dismissButton;
}
 - (void)setTransitioningDelegate:(id<UIViewControllerTransitioningDelegate>)transitioningDelegate
{
    [super setTransitioningDelegate:transitioningDelegate];
    self.presentationController.delegate = self;
}
 - (IBAction)dismissButtonAction:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"unwindToFirstViewController" sender:sender];
}
#pragma mark -
#pragma mark UIAdaptivePresentationControllerDelegate
 - (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
     return UIModalPresentationFullScreen;
}
 - (UIViewController*)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
    return [[UINavigationController alloc] initWithRootViewController:controller.presentedViewController];
}
@end
