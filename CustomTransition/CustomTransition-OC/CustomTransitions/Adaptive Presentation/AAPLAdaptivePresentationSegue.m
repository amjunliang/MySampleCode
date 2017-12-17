/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 */
#import "AAPLAdaptivePresentationSegue.h"
#import "AAPLAdaptivePresentationController.h"
@implementation AAPLAdaptivePresentationSegue
 
- (void)perform
{
    UIViewController *sourceViewController = self.destinationViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
     
     
     
     
     
     
     
     
    AAPLAdaptivePresentationController *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
    
    presentationController = [[AAPLAdaptivePresentationController alloc] initWithPresentedViewController:destinationViewController presentingViewController:sourceViewController];
    
    destinationViewController.transitioningDelegate = presentationController;
    
    [self.sourceViewController presentViewController:destinationViewController animated:YES completion:NULL];
}
@end
