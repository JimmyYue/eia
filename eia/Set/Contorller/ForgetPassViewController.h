//
//  ForgetPassViewController.h
//  HouseKeeper
//
//  Created by JimmyYue on 2018/8/13.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPassViewController : InheritanceViewController

@property (strong, nonatomic) IBOutlet UITextField *phoneText;

@property (strong, nonatomic) IBOutlet UITextField *passText;

@property (strong, nonatomic) IBOutlet UITextField *messageText;

@property (strong, nonatomic) IBOutlet UIButton *messageBtn;

- (IBAction)sureBtn:(id)sender;

@property (nonatomic, strong) NSString *timeType;
@property (nonatomic, assign) int secondsCountDown; //倒计时总时长
@property (nonatomic, strong) NSTimer *countDownTimer;

@property (weak, nonatomic) IBOutlet UITextField *surePassText;


@end
