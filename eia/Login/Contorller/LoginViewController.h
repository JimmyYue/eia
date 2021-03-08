//
//  LoginViewController.h
//  eia
//
//  Created by JimmyYue on 2020/5/7.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWTabBarController.h"
#import "SAMKeychain.h"
#import "NSString+MD5.h"
#import "ForgetPassViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

- (IBAction)loginBtnAction:(id)sender;

@property (nonatomic, strong) NSString *type;

- (IBAction)forgotPasswordBtnAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
