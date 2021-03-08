//
//  LoginViewController.m
//  eia
//
//  Created by JimmyYue on 2020/5/7.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

//-(void)keyboardHide:(UITapGestureRecognizer*)tap{
//    [self.view endEditing:YES];
//}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    
    //  触摸空白处隐藏键盘
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
//    tapGestureRecognizer.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.phoneText.layer.borderColor = TabbarBlack_S.CGColor;
    self.phoneText.layer.borderWidth = 1.0;
    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"UserPhone"]] == NO) {
        self.phoneText.text = [XYCommon GetUserDefault:@"UserPhone"];
    }
    
    self.passwordText.layer.borderColor = TabbarBlack_S.CGColor;
    self.passwordText.layer.borderWidth = 1.0;
    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"Secure"]] == NO) {
        self.passwordText.text = [XYCommon GetUserDefault:@"Secure"];
    }
}

- (IBAction)forgotPasswordBtnAction:(id)sender {
    ForgetPassViewController *forgetPassVC = [[ForgetPassViewController alloc] init];
    [self.navigationController pushViewController:forgetPassVC animated:YES];
}

- (IBAction)loginBtnAction:(id)sender {
    
    if ([IsBlankString isBlankString:self.phoneText.text] == YES) {
           [SVProgressHUD showInfoWithStatus:@"请填写账号!"];
       } else {
           self.phoneText.text = [XYCommon isCorrectNumber:self.phoneText.text];

           if ([XYCommon isMobileNumber:self.phoneText.text] == NO) {
               [SVProgressHUD showInfoWithStatus:@"请填写正确的手机号码!"];
           } else {
               if ([IsBlankString isBlankString:self.passwordText.text] == YES) {
                   [SVProgressHUD showInfoWithStatus:@"请填写密码!"];
               } else {
                   
                   NSString *deviceBrand = [[UIDevice currentDevice].name stringByReplacingOccurrencesOfString:@"“" withString:@""];
                   deviceBrand = [deviceBrand stringByReplacingOccurrencesOfString:@"”" withString:@""];
                   deviceBrand = [deviceBrand stringByReplacingOccurrencesOfString:@" " withString:@""];
                   
                   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                      hud.label.text = @"登录中...";
                      
                   [NetworkHandler requestPostWithUrl:API_BASE_URL(@"userEmployee/login") parameters:@{@"entity":@{@"secure":self.passwordText.text, @"userPhone":self.phoneText.text, @"deviceBrand":deviceBrand, @"deviceToken":UMKey, @"identifyNumber":[NSString stringWithFormat:@"%@", [self getDeviceId]], @"tokenType":@"mobile"}} view:nil completion:^(id result) {
                          
                          if ([result[@"isSuccess"] intValue] == 1) {
                              
                              //  如果未切换用户 则不刷新数据 (巡查企业与个人中心)
                              NSString *reload;
                              if ([self.phoneText.text isEqualToString:[XYCommon GetUserDefault:@"UserPhone"]]) {
                                  reload = @"no";
                              } else {
                                  reload = @"yes";
                              }
                              
                              [XYCommon SetUserDefault:@"Login" byValue:@"yes"];
                              
                              if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"token"]]] == NO) {
                                  [XYCommon SetUserDefault:@"Request_token" byValue:[NSString stringWithFormat:@"%@", result[@"token"]]];
                              }
                              
                              [XYCommon SetUserDefault:@"Id" byValue:[NSString stringWithFormat:@"%@", result[@"result"][@"id"]]];
                              [XYCommon SetUserDefault:@"OwnerDeptName" byValue:[NSString stringWithFormat:@"%@", result[@"result"][@"ownerDeptName"]]];
                              [XYCommon SetUserDefault:@"UserName" byValue:[NSString stringWithFormat:@"%@", result[@"result"][@"userName"]]];
                              [XYCommon SetUserDefault:@"UserPhone" byValue:[NSString stringWithFormat:@"%@", result[@"result"][@"userPhone"]]];
                              [XYCommon SetUserDefault:@"Secure" byValue:self.passwordText.text];
                              [XYCommon SetUserDefault:@"Avatar" byValue:[NSString stringWithFormat:@"%@", result[@"result"][@"avatar"]]];
                              
                              if ([self.type isEqualToString:@"net"]) {
                                  
                                  if ([reload isEqualToString:@"yes"]) {  // 切换用户后刷新数据信息(巡查企业与个人中心)
                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadList" object:nil userInfo:nil];
                                  }
                                  
                                  [UIView transitionWithView:self.navigationController.view duration:0.4 options:UIViewAnimationOptionCurveEaseIn animations:^{
                                      CATransition* transition = [CATransition animation];
                                      transition.duration =0.4f;
                                      transition.type = kCATransitionReveal;
                                      transition.subtype = kCATransitionFromBottom;
                                      transition.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
                                      [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                                      
                                      [self.navigationController popViewControllerAnimated:NO];
                                      
                                  } completion:nil];
                                  
                              } else {
                                  DWTabBarController *viewVC = [[DWTabBarController alloc] init];
                                  [self.navigationController pushViewController:viewVC animated:NO];
                              }
                           
                              [XYCommon SetUserDefault:@"LoginN" byValue:@"YES"];
                              
                          } else {
                              [SVProgressHUD showInfoWithStatus:result[@"message"]];
                          }
                          
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                      } failure:^(NSError *error) {
                          NSLog(@"%@", error);
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                      }];
               }
           }
       }
}

- (NSString *)getDeviceId
{
    NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:@" " account:@"uuid"];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
    {
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SAMKeychain setPassword: currentDeviceUUIDStr forService:@" " account:@"uuid"];
    }
    return currentDeviceUUIDStr;
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
