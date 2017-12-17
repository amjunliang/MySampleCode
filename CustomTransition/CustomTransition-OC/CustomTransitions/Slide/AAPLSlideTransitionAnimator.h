/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A transition animator that transitions between two view controllers in
  a tab bar controller by sliding both view controllers in a given
  direction.
 */
@import UIKit;
@interface AAPLSlideTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;
 
  
 
@property (nonatomic, readwrite) UIRectEdge targetEdge;
@end
