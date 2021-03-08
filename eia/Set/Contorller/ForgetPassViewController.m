//
//  ForgetPassViewController.m
//  HouseKeeper
//
//  Created by JimmyYue on 2018/8/13.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "ForgetPassViewController.h"

@interface ForgetPassViewController ()

@end

@implementation ForgetPassViewController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _timeType = @"star";
    
    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"UserPhone"]] == NO) {
        self.phoneText.text = [XYCommon GetUserDefault:@"UserPhone"];
    }
    
    [self.messageBtn addTarget:self action:@selector(messageBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)messageBtnAction {
    
    if ([IsBlankString isBlankString:self.phoneText.text] == YES) {
        [SVProgressHUD showInfoWithStatus:@"请填写手机号!"];
    } else {
        
        self.phoneText.text = [XYCommon isCorrectNumber:self.phoneText.text];
        
        if ([XYCommon isMobileNumber:self.phoneText.text] == NO) {
            [SVProgressHUD showInfoWithStatus:@"请填写正确的手机号码!"];
        } else {
            
            if ([_timeType isEqualToString:@"star"]) {
                
                //设置倒计时总时长
                _secondsCountDown = 60;  // 60秒倒计时
                //开始倒计时
                _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
                
                _timeType = @"end";
                
                [NetworkHandler requestPostWithUrl:API_BASE_URL(@"emp/verifyCode") parameters:@{@"userPhone":self.phoneText.text} view:nil completion:^(id result) {
                    
                } failure:^(NSError *error) {
                    
                }];
                
            }
        }
    }
}

-(void)timeFireMethod{
    //倒计时-1
    _secondsCountDown--;
    //设置倒计时显示的时间
    [self.messageBtn setTitle:[NSString stringWithFormat:@"%d秒后重新获取",_secondsCountDown] forState:UIControlStateNormal];
    if(_secondsCountDown==0){
        [_countDownTimer invalidate];
        [self.messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _timeType = @"star";
    }
}

- (IBAction)sureBtn:(id)sender {
    
    if ([IsBlankString isBlankString:self.phoneText.text] == YES) {
        [SVProgressHUD showInfoWithStatus:@"请填写手机号!"];
    } else {
        
        self.phoneText.text = [XYCommon isCorrectNumber:self.phoneText.text];
        
        if ([XYCommon isMobileNumber:self.phoneText.text] == NO) {
            [SVProgressHUD showInfoWithStatus:@"请填写正确的手机号码!"];
        } else {
            
            if ([IsBlankString isBlankString:self.passText.text] == YES) {
                [SVProgressHUD showInfoWithStatus:@"请填写新密码!"];
            } else {
                
                if (![self.passText.text isEqualToString:self.surePassText.text]) {
                    [SVProgressHUD showInfoWithStatus:@"密码与验证密码不符!"];
                } else {
                    
                    if ([IsBlankString isBlankString:self.messageText.text] == YES) {
                        [SVProgressHUD showInfoWithStatus:@"请填写验证码!"];
                    } else {
                        
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.label.text = @"提交中...";
                        
                        [NetworkHandler requestPostWithUrl:API_BASE_URL(@"emp/updatePassWord") parameters:@{@"userPhone":self.phoneText.text, @"verifyCode":self.messageText.text, @"newPassWord":self.passText.text} view:nil completion:^(id result) {
                            
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            
                            if ([result[@"isSuccess"] integerValue] == 1) {
                                [XYCommon SetUserDefault:@"Secure" byValue:self.passText.text];  // 密码
                                [self.navigationController popViewControllerAnimated:YES];
                            }
                            
                            [SVProgressHUD showInfoWithStatus:result[@"message"]];
                            
                        } failure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                        }];
                    }
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
