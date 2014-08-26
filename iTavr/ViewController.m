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
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
        [self sendSMS:@"91#301"];
    }
    else{
        [self sendSMS:@"91#300"];
    }
}

- (void)sendSMS:(NSString*)msg{
    //TODO: Implement this.
    NSLog([NSString stringWithFormat:@"Sending SMS to Tavr with text: %@", msg]);
}

- (IBAction)switchButtonTapped:(id)sender {
}
@end
