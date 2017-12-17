/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
  Abstract:
 A custom storyboard segue that loads its destination view controller from an
  external storyboard (named by the segue's identifier), then presents it 
  modally.
 */
#import "AAPLExternalStoryboardSegue.h"
 @implementation AAPLExternalStoryboardSegue
 - (instancetype)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
     UIStoryboard *externalStoryboard = [UIStoryboard storyboardWithName:identifier bundle:[NSBundle bundleForClass:self.class]];
     id initialViewController = [externalStoryboard instantiateInitialViewController];
     return [super initWithIdentifier:identifier source:source destination:initialViewController];
}
 - (void)perform
{
    [self.sourceViewController presentViewController:self.destinationViewController animated:YES completion:NULL];
}
@end
