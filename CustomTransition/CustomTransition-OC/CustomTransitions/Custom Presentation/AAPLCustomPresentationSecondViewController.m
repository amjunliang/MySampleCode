/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The second view controller for the Custom Presentation demo.
 */
#import "AAPLCustomPresentationSecondViewController.h"
                          
@interface AAPLCustomPresentationSecondViewController ()
@property (nonatomic, weak) IBOutlet UISlider *slider;
@end
@implementation AAPLCustomPresentationSecondViewController
 - (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    
                                  /* self.modalPresentationCapturesStatusBarAppearance = YES; */
}
 - (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
              [self updatePreferredContentSizeWithTraitCollection:newCollection];
}
    - (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection
{
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : 420);
    
                                       self.slider.maximumValue = self.preferredContentSize.height;
    self.slider.minimumValue = 220.f;
    self.slider.value = self.slider.maximumValue;
}
 - (IBAction)sliderValueChange:(UISlider*)sender
{
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, sender.value);
}
#pragma mark -
#pragma mark Unwind Actions
   - (IBAction)unwindToCustomPresentationSecondViewController:(UIStoryboardSegue *)sender
{ }
@end
