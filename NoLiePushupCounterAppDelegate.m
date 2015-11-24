//
//  NoLiePushupCounterAppDelegate.m
//  NoLiePushupCounter
//
//  Created by Don Greenberg Greenberg on 12/31/11.
//

#import "NoLiePushupCounterAppDelegate.h"

@implementation NoLiePushupCounterAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    doneButton.hidden = YES;
    [doneButton setEnabled:NO];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

-(void)textFieldDidBeginEditing:(UITextField *)tf
{
    doneButton.hidden = NO;
    [doneButton setEnabled:YES];
    currentTF = tf;
}

-(void)textFieldDidEndEditing:(UITextField *)tf
{
    //If the text field is the number of reps, doesn't neg one display if it's zero
    if([[tf placeholder] isEqualToString:@"Reps"]) {
        numRepsRemaining = [[tf text] intValue];
        numOfRepsTotal = numRepsRemaining;
        if (numRepsRemaining != 0) {
            repsRemaining.text = [NSString stringWithFormat:@"%d", numRepsRemaining-1];
        } else {
            repsRemaining.text = [NSString stringWithFormat:@"%d", numRepsRemaining];
        }
    //Set the number of pushups per rep
    } else {
        numPushupsPerRep = [[tf text] intValue];
    }
    
    if (numRepsRemaining != 0) {
        pushupsRemaining.text =[NSString stringWithFormat:@"%d", (numPushupsPerRep*numRepsRemaining)];
    }
    
    //Hide and disable the done button
    doneButton.hidden = YES;
    [doneButton setEnabled:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)tf
{
    
    return YES;
}

-(IBAction)reset:(id)sender
{
    //Re-initialize the number of pushups this rep, totalPushupsDone, and numRepsRemaining
    numPushupsThisRep = 0;
    numTotalPushupsDone = 0;
    numRepsRemaining = [numOfReps.text intValue];
    
    //Set the pushupsDoneInRep and totalPushupsDone main button to zero
    [pushupsDoneInRep setTitle:[NSString stringWithFormat:@"%d", numTotalPushupsDone]
                      forState:0];
    totalPushupsDone.text = [NSString stringWithFormat:@"%d", numTotalPushupsDone];
    
    //Make numRepsRemaining equal to the remaining reps and calculate pushupsRemaining.
    //if numRepsRemaining is zero, the value will display negative, so don't 
    if (numRepsRemaining != 0) {
        pushupsRemaining.text =[NSString stringWithFormat:@"%d", (numPushupsPerRep*(numRepsRemaining-1)) + (numPushupsPerRep - numPushupsThisRep)];
        repsRemaining.text = [NSString stringWithFormat:@"%d", numRepsRemaining-1];
    } else {
        pushupsRemaining.text =[NSString stringWithFormat:@"%d", (numPushupsPerRep - numPushupsThisRep)];
        repsRemaining.text = [NSString stringWithFormat:@"%d", numRepsRemaining];
    }
    
    //Show the main pushupsDoneInRep button so it displays again after being disabled after
    //the user finished
    pushupsDoneInRep.hidden = NO;
}

-(IBAction)done:(id)sender
{
    [currentTF resignFirstResponder];
}


-(IBAction)pushupDone:(id)sender
{
    //If either the user chooses zero reps or doesn't select, just increment and
    //display how many pushups were done
    if (!(numOfRepsTotal == 0 || numPushupsPerRep == 0)) {
        
        //increment the number of pushups done this rep and total pushups
        numPushupsThisRep++;
        numTotalPushupsDone++;
        
        //Set the total pushups for all instances
        totalPushupsDone.text = [NSString stringWithFormat:@"%d", numTotalPushupsDone];
        
        //if all the pushups are complete, make it all say "DONE" and remove the 
        //pushupsDoneInRep button so the user can't break shit
        if (numPushupsThisRep == numPushupsPerRep && numRepsRemaining == 1) {
            [pushupsRemaining setText:@"Done!"];
            [repsRemaining setText:@"Done!"];
            pushupsDoneInRep.hidden = YES;
        }else {
            
            //if the final count isn't up, check if the rep is up. If it is, decrement the
            //numRepsRemaining, and reset the numPushupsThisRep
            if (numPushupsThisRep >= numPushupsPerRep) {
                numRepsRemaining--;
                numPushupsThisRep = 0;
            }
            
            //Display the pushups left in the rep on the main button
            [pushupsDoneInRep setTitle:[NSString stringWithFormat:@"%d", numPushupsPerRep - numPushupsThisRep] 
                          forState:0];
            
            //Display the remaining pushups in all the reps
            pushupsRemaining.text =[NSString stringWithFormat:@"%d", (numPushupsPerRep*(numRepsRemaining -1)) + (numPushupsPerRep - numPushupsThisRep)];
            
            //display one minus the reps remaining, skip it if it'll be negative.
            if (numRepsRemaining != 0) {
                repsRemaining.text = [NSString stringWithFormat:@"%d", numRepsRemaining-1];
            } else {
                repsRemaining.text = [NSString stringWithFormat:@"%d", numRepsRemaining];
            }
        }
    //if they haven't set a rep ammount, then just increment the totalPushupsDone and the
    //pushupsDoneInRep
    } else {
        numTotalPushupsDone++;
        [pushupsDoneInRep setTitle:[NSString stringWithFormat:@"%d", numTotalPushupsDone]
                          forState:0];
        totalPushupsDone.text = [NSString stringWithFormat:@"%d", numTotalPushupsDone];
    }
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
