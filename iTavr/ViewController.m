//
//  ViewController.m
//  iTavr
//
//  Created by Alexey Tsymlov on 25/08/14.
//  Copyright (c) 2014 alexeytsymlov. All rights reserved.
//

#import "ViewController.h"

#define kTestPhoneNumber @"+7(929)573-94-22"
#define kTurnPerimeterOnCommand @"91#301"
#define kTurnPerimeterOffCommand @"91#300"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tavrPhoneNumber =  kTestPhoneNumber; //TODO: Load this value from settings.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)perimeterChanged:(id)sender {
    UISwitch *perimeter = (UISwitch *)sender;
    if ([perimeter isOn]) {
        [self sendSMS:kTurnPerimeterOnCommand];
    }
    else{
        [self sendSMS:kTurnPerimeterOffCommand];
    }
}

- (void)sendSMS:(NSString*)msg{
    NSLog(@"Sending SMS to %@ with text: %@", tavrPhoneNumber, msg);
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = msg;
        controller.recipients = [NSArray arrayWithObjects:tavrPhoneNumber, nil];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (result == MessageComposeResultCancelled){
        NSLog(@"Message cancelled");
        [self invertPerimeterSwitch];
    }
    else if (result == MessageComposeResultSent){
        NSLog(@"Message sent");
    }
    else{
        NSLog(@"Message failed");
        [self invertPerimeterSwitch];
    }
}

- (void)invertPerimeterSwitch{
    [self.perimeterSwitch setOn: ![self.perimeterSwitch isOn] animated:YES];
}

- (IBAction)switchButtonTapped:(id)sender {
}
@end
