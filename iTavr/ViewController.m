//
//  ViewController.m
//  iTavr
//
//  Created by Alexey Tsymlov on 25/08/14.
//  Copyright (c) 2014 alexeytsymlov. All rights reserved.
//

#import "ViewController.h"

#define kTurnPerimeterOnCommand @"91#301"
#define kTurnPerimeterOffCommand @"91#300"
#define kTurnTavrOnCommand @"3333"
#define kTurnTavrOffCommand @"2222"
#define kBalanceRequestCommand @"4444"
#define kAlarmRequestCommand @"5555"
#define kStateRequestCommand @"1111"
#define kSettingsRequestCommand @"91#"

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)turnOnButtonTapped:(id)sender {
    [self turnTavrOn];
}

- (IBAction)turnOffButtonTapped:(id)sender {
    [self turnTavrOff];
}

- (IBAction)fullSecurityButtonTapped:(id)sender {
    [self turnFullSecurityOn];
}

- (IBAction)perimeterButtonTapped:(id)sender {
    [self turnPerimeterOn];
}

- (IBAction)balanceRequestButtonTapped:(id)sender {
    [self sendBalanceRequest];
}

- (IBAction)alarmRequestButtonTapped:(id)sender {
    [self sendAlarmRequest];
}

- (IBAction)stateRequestButtonTapped:(id)sender {
    [self sendStateRequest];
}

- (IBAction)settingsRequestButtonTapped:(id)sender {
    [self sendSettingsRequest];
}

- (void)turnPerimeterOn {
    [self sendSMS:kTurnPerimeterOnCommand];
}

- (void)turnFullSecurityOn {
    [self sendSMS:kTurnPerimeterOffCommand];
}

- (void)turnTavrOff {
    [self sendSMS:kTurnTavrOffCommand];
}

- (void)turnTavrOn {
    [self sendSMS:kTurnTavrOnCommand];
}

- (void)sendBalanceRequest{
    [self sendSMS:kBalanceRequestCommand];
}

- (void)sendAlarmRequest{
    [self sendSMS:kAlarmRequestCommand];
}

- (void)sendStateRequest{
    [self sendSMS:kStateRequestCommand];
}

- (void)sendSettingsRequest{
    [self sendSMS:kSettingsRequestCommand];
}

- (void)sendSMS:(NSString*)msg{
    extern NSString* gTavrPhoneNumber;
    NSLog(@"Sending SMS to %@ with text: %@", gTavrPhoneNumber, msg);
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText]){
        controller.body = msg;
        controller.recipients = [NSArray arrayWithObjects:gTavrPhoneNumber, nil];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (result == MessageComposeResultCancelled){
        NSLog(@"Message cancelled");
    }
    else if (result == MessageComposeResultSent){
        NSLog(@"Message sent");
    }
    else{
        NSLog(@"Message failed");
    }
}
@end
