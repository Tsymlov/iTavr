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
#define kTurnTavrOnCommand @"3333"
#define kTurnTavrOffCommand @"2222"

@interface ViewController (){
    bool isTavrOn;
}
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    tavrPhoneNumber =  [defaults objectForKey:@"tavrPhoneNumber"];
    isTavrOn = NO; //TODO: Request a state from Tavr.
    [self refreshMainButton];
    [self.perimeterSwitch setOn:NO];
}

- (void)refreshMainButton{
    self.mainButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.mainButton.titleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    if (isTavrOn) {
        self.mainButton.titleLabel.text = @"Выключить";
        self.mainButton.backgroundColor = [UIColor redColor];
    }
    else{
        self.mainButton.titleLabel.text = @"Включить";
        self.mainButton.backgroundColor = [UIColor greenColor];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)perimeterChanged:(id)sender {
    UISwitch *perimeter = (UISwitch *)sender;
    if ([perimeter isOn]) {
        [self turnPerimeterOn];
    }
    else{
        [self turnPerimeterOff];
    }
}

- (void)turnPerimeterOn {
    [self sendSMS:kTurnPerimeterOnCommand];
}

- (void)turnPerimeterOff {
    [self sendSMS:kTurnPerimeterOffCommand];
}

- (void)sendSMS:(NSString*)msg{
    NSLog(@"Sending SMS to %@ with text: %@", tavrPhoneNumber, msg);
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText]){
        controller.body = msg;
        controller.recipients = [NSArray arrayWithObjects:tavrPhoneNumber, nil];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (result == MessageComposeResultCancelled){
        NSLog(@"Message cancelled");
        if ([controller.body  isEqual: kTurnPerimeterOffCommand]||[controller.body  isEqual: kTurnPerimeterOnCommand]) {
            [self cancelationOfTurningPerimeter];
        }
    }
    else if (result == MessageComposeResultSent){
        NSLog(@"Message sent");
        if ([controller.body isEqual: kTurnTavrOffCommand]||[controller.body isEqual: kTurnTavrOnCommand]) {
            [self completionOfTurningTavr];
        }
    }
    else{
        NSLog(@"Message failed");
        if ([controller.body  isEqual: kTurnPerimeterOffCommand]||[controller.body  isEqual: kTurnPerimeterOnCommand]) {
            [self cancelationOfTurningPerimeter];
        }
    }
}

- (void)cancelationOfTurningPerimeter{
    [self invertPerimeterSwitch];
}

- (void)invertPerimeterSwitch{
    [self.perimeterSwitch setOn: ![self.perimeterSwitch isOn] animated:YES];
}

- (void)completionOfTurningTavr{
    isTavrOn = !isTavrOn;
    [self refreshMainButton];
}

- (IBAction)mainButtonTapped:(id)sender {
    if (isTavrOn) {
        [self turnTavrOff];
    }
    else{
        [self turnTavrOn];
    }
}

- (IBAction)infoButtonTapped:(id)sender {
    [self sendSMS:@"4444"];
}

- (void)turnTavrOff {
    [self sendSMS:kTurnTavrOffCommand];
}

- (void)turnTavrOn {
    [self sendSMS:kTurnTavrOnCommand];
}
@end
