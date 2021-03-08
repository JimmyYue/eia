//
//  SettingViewController.h
//  HouseKeeper
//
//  Created by JimmyYue on 2018/8/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "ChooseLocationViewController.h"
#import <PgyUpdate/PgyUpdateManager.h>

@interface SettingViewController : InheritanceViewController

- (IBAction)clearBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

- (IBAction)checkUpdataBtn:(id)sender;

@property (strong, nonatomic) NSString *urlStr;

@end
