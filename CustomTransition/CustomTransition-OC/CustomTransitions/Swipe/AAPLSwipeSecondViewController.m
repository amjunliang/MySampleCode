
#import "AAPLSwipeSecondViewController.h"
#import "AAPLSwipeTransitionDelegate.h"
@interface AAPLSwipeSecondViewController ()
@end
@implementation AAPLSwipeSecondViewController
 - (void)viewDidLoad
{
    [super viewDidLoad];
    
              UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    interactiveTransitionRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
}
   - (IBAction)interactiveTransitionRecognizerAction:(UIScreenEdgePanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
                                   [self performSegueWithIdentifier:@"BackToFirstViewController" sender:sender];
    }
}
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BackToFirstViewController"])
    {
                                            if ([self.transitioningDelegate isKindOfClass:AAPLSwipeTransitionDelegate.class])
        {
            AAPLSwipeTransitionDelegate *transitionDelegate = self.transitioningDelegate;
            
                                                                if ([sender isKindOfClass:UIGestureRecognizer.class])
                transitionDelegate.gestureRecognizer = sender;
            else
                transitionDelegate.gestureRecognizer = nil;
            
                                                                                                                    transitionDelegate.targetEdge = UIRectEdgeLeft;
        }
    }
}
@end
