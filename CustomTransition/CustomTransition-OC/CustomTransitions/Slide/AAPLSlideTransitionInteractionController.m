/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The interaction controller for the Slide demo.
 */
#import "AAPLSlideTransitionInteractionController.h"
@interface AAPLSlideTransitionInteractionController ()
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *gestureRecognizer;
@property (nonatomic, readwrite) CGPoint initialLocationInContainerView;
@property (nonatomic, readwrite) CGPoint initialTranslationInContainerView;
@end
@implementation AAPLSlideTransitionInteractionController
 
- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    self = [super init];
    if (self)
    {
        _gestureRecognizer = gestureRecognizer;
        
         
         
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}
 
- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Use -initWithGestureRecognizer:" userInfo:nil];
}
 
- (void)dealloc
{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}
 
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
     
     
    self.transitionContext = transitionContext;
    self.initialLocationInContainerView = [self.gestureRecognizer locationInView:transitionContext.containerView];
    self.initialTranslationInContainerView = [self.gestureRecognizer translationInView:transitionContext.containerView];
    
    [super startInteractiveTransition:transitionContext];
}
 
  
 
  
 
- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture
{
    UIView *transitionContainerView = self.transitionContext.containerView;
    
    CGPoint translationInContainerView = [gesture translationInView:transitionContainerView];
    
     
     
     
     
     
    if ((translationInContainerView.x > 0.f && self.initialTranslationInContainerView.x < 0.f) ||
        (translationInContainerView.x < 0.f && self.initialTranslationInContainerView.x > 0.f))
        return -1.f;
    
     
    return fabs(translationInContainerView.x) / CGRectGetWidth(transitionContainerView.bounds);
}
 
  
 
- (IBAction)gestureRecognizeDidUpdate:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
             
             
             
            break;
        case UIGestureRecognizerStateChanged:
             
             
             
             
             
            if ([self percentForGesture:gestureRecognizer] < 0.f) {
                [self cancelInteractiveTransition];
                 
                 
                [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
            } else {
                 
                 
                [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            }
            break;
        case UIGestureRecognizerStateEnded:
             
             
            if ([self percentForGesture:gestureRecognizer] >= 0.4f)
                [self finishInteractiveTransition];
            else
                [self cancelInteractiveTransition];
            break;
        default:
             
            [self cancelInteractiveTransition];
            break;
    }
}
@end
