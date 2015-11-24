//
//  NoLiePushupCounterAppDelegate.h
//  NoLiePushupCounter
//
//  Created by Don Greenberg Greenberg on 12/31/11.
//

#import <UIKit/UIKit.h>

@interface NoLiePushupCounterAppDelegate : NSObject <UIApplicationDelegate, UITextFieldDelegate>
{
    IBOutlet UILabel *repsRemaining;
    IBOutlet UILabel *pushupsRemaining;
    IBOutlet UILabel *totalPushupsDone;
    IBOutlet UIButton *pushupsDoneInRep;
    IBOutlet UIButton *reset;
    IBOutlet UITextField *numOfReps;
    IBOutlet UITextField *pushupsPerRep;
    IBOutlet UIButton *doneButton;
    int numOfRepsTotal;
    int numPushupsPerRep;
    int numRepsRemaining;
    int numTotalPushupsDone;
    int numPushupsThisRep;
    UITextField *currentTF;
}

-(IBAction)pushupDone:(id)sender;
-(IBAction)reset:(id)sender;
-(IBAction)done:(id)sender;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
