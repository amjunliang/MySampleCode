/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The delegate of the tab bar controller for the Slide demo.  Manages the
  gesture recognizer used for the interactive transition.  Vends
  instances of AAPLSlideTransitionAnimator and 
  AAPLSlideTransitionInteractionController.
 */
#import "AAPLSlideTransitionDelegate.h"
#import "AAPLSlideTransitionAnimator.h"
#import "AAPLSlideTransitionInteractionController.h"
#import <objc/runtime.h>
  
 
const char * AAPLSlideTabBarControllerDelegateAssociationKey = "AAPLSlideTabBarControllerDelegateAssociation";
@interface AAPLSlideTransitionDelegate ()
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@end
@implementation AAPLSlideTransitionDelegate
  
 
  
 
  
 
  
 
- (void)setTabBarController:(UITabBarController *)tabBarController
{
    if (tabBarController != _tabBarController) {
         
         
        objc_setAssociatedObject(_tabBarController, AAPLSlideTabBarControllerDelegateAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [_tabBarController.view removeGestureRecognizer:self.panGestureRecognizer];
        if (_tabBarController.delegate == self) _tabBarController.delegate = nil;
        
        _tabBarController = tabBarController;
        
        _tabBarController.delegate = self;
        [_tabBarController.view addGestureRecognizer:self.panGestureRecognizer];
         
         
         
        objc_setAssociatedObject(_tabBarController, AAPLSlideTabBarControllerDelegateAssociationKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
#pragma mark -
#pragma mark Gesture Recognizer
  
 
  
 
- (UIPanGestureRecognizer*)panGestureRecognizer
{
    if (_panGestureRecognizer == nil)
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerDidPan:)];
    
    return _panGestureRecognizer;
}
 
  
 
- (IBAction)panGestureRecognizerDidPan:(UIPanGestureRecognizer*)sender
{
     
     
    if (self.tabBarController.transitionCoordinator)
        return;
    
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged)
        [self beginInteractiveTransitionIfPossible:sender];
    
     
     
}
  
 
  
 
- (void)beginInteractiveTransitionIfPossible:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.tabBarController.view];
    
    if (translation.x > 0.f && self.tabBarController.selectedIndex > 0) {
         
        self.tabBarController.selectedIndex--;
    } else if (translation.x < 0.f && self.tabBarController.selectedIndex + 1 < self.tabBarController.viewControllers.count) {
         
        self.tabBarController.selectedIndex++;
    } else {
         
         
         
        if (!CGPointEqualToPoint(translation, CGPointZero)) {
             
             
            sender.enabled = NO;
            sender.enabled = YES;
        }
    }
    
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
    [self.tabBarController.transitionCoordinator animateAlongsideTransition:NULL completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if ([context isCancelled] && sender.state == UIGestureRecognizerStateChanged)
            [self beginInteractiveTransitionIfPossible:sender];
    }];
}
#pragma mark -
#pragma mark UITabBarControllerDelegate
 
  
 
  
 
  
 
- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    NSAssert(tabBarController == self.tabBarController, @"%@ is not the tab bar controller currently associated with %@", tabBarController, self);
    NSArray *viewControllers = tabBarController.viewControllers;
    
    if ([viewControllers indexOfObject:toVC] > [viewControllers indexOfObject:fromVC]) {
         
         
        return [[AAPLSlideTransitionAnimator alloc] initWithTargetEdge:UIRectEdgeLeft];
    } else {
         
         
        return [[AAPLSlideTransitionAnimator alloc] initWithTargetEdge:UIRectEdgeRight];
    }
}
 
  
 
  
 
  
 
  
 
- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    NSAssert(tabBarController == self.tabBarController, @"%@ is not the tab bar controller currently associated with %@", tabBarController, self);
    
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        return [[AAPLSlideTransitionInteractionController alloc] initWithGestureRecognizer:self.panGestureRecognizer];
    } else {
         
         
        return nil;
    }
}
@end
