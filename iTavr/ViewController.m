//
//  ViewController.m
//  iTavr
//
//  Created by Alexey Tsymlov on 25/08/14.
//  Copyright (c) 2014 alexeytsymlov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tavrPhoneNumber = @"+7(929)573-94-22"; //TODO: Load this value from settings.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)perimeterChanged:(id)sender {
    UISwitch *perimeter = (UISwitch *)sender;
    if ([perimeter isOn]) {
        [self sendSMS:@"91#301"];
    }
    else{
        [self sendSMS:@"91#300"];
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
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
        NSLog(@"Message sent");
    else
        NSLog(@"Message failed");
}

- (IBAction)switchButtonTapped:(id)sender {
}
@end
