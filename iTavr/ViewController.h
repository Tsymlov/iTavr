//
//  ViewController.h
//  iTavr
//
//  Created by Alexey Tsymlov on 25/08/14.
//  Copyright (c) 2014 alexeytsymlov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface ViewController : UIViewController <MFMessageComposeViewControllerDelegate>

- (IBAction)turnOnButtonTapped:(id)sender;
- (IBAction)turnOffButtonTapped:(id)sender;
- (IBAction)fullSecurityButtonTapped:(id)sender;
- (IBAction)perimeterButtonTapped:(id)sender;
- (IBAction)balanceRequestButtonTapped:(id)sender;
- (IBAction)alarmRequestButtonTapped:(id)sender;
- (IBAction)stateRequestButtonTapped:(id)sender;
- (IBAction)settingsRequestButtonTapped:(id)sender;
@end
