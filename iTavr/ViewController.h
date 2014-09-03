//
//  ViewController.h
//  iTavr
//
//  Created by Alexey Tsymlov on 25/08/14.
//  Copyright (c) 2014 alexeytsymlov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface ViewController : UIViewController <MFMessageComposeViewControllerDelegate> {
    NSString *tavrPhoneNumber;
}

@property (weak, nonatomic) IBOutlet UISwitch *perimeterSwitch;
@property (weak, nonatomic) IBOutlet UIButton *mainButton;
@property (weak, nonatomic) IBOutlet UILabel *balance;
- (IBAction)perimeterChanged:(id)sender;
- (IBAction)mainButtonTapped:(id)sender;
- (IBAction)infoButtonTapped:(id)sender;

@end
