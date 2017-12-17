/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The delegate of the tab bar controller for the Slide demo.  Manages the
  gesture recognizer used for the interactive transition.  Vends
  instances of AAPLSlideTransitionAnimator and 
  AAPLSlideTransitionInteractionController.
 */
@import UIKit;
@interface AAPLSlideTransitionDelegate : NSObject <UITabBarControllerDelegate>
 
@property (nonatomic, weak) IBOutlet UITabBarController *tabBarController;
 
  
 
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *panGestureRecongizer;
@end
