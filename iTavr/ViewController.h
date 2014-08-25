//
//  ViewController.h
//  iTavr
//
//  Created by Alexey Tsymlov on 25/08/14.
//  Copyright (c) 2014 alexeytsymlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSString *tavrPhoneNumber;
}

@property (weak, nonatomic) IBOutlet UISwitch *perimeter;
- (IBAction)perimeterChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *switchButton;
- (IBAction)switchButtonTapped:(id)sender;

@end
