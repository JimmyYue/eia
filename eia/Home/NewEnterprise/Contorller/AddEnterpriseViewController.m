//
//  AddEnterpriseViewController.m
//  eia
//
//  Created by JimmyYue on 2020/7/4.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "AddEnterpriseViewController.h"
#import "HomeSearchViewController.h"
#import "BasicTopChooseEnterpriseView.h"
#import "AddEnterpriseBottomView.h"

@interface AddEnterpriseViewController ()

@end

@implementation AddEnterpriseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新建企业档案";
    self.view.backgroundColor = BackgroundBlack;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 1, kDeviceWidth - 10, kDeviceHeight - NavRect - StatusRect - 91)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(0, 756);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    UILabel *enterpriseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 67, 35)];
    enterpriseLabel.text = @"企业名称";
    enterpriseLabel.font = [UIFont systemFontOfSize:16];
    [self.scrollView addSubview:enterpriseLabel];
    
    self.enterpriseText = [[UITextField alloc]initWithFrame:CGRectMake(enterpriseLabel.frame.origin.x + enterpriseLabel.frame.size.width + 15, 10, kDeviceWidth - (enterpriseLabel.frame.origin.x + enterpriseLabel.frame.size.width + 30), 35)];
    self.enterpriseText.textColor = [UIColor blackColor];
    self.enterpriseText.font = [UIFont systemFontOfSize:15];
    self.enterpriseText.backgroundColor = RGBCOLOR(240, 240, 240);
    [self.enterpriseText.layer setMasksToBounds:YES];
    self.enterpriseText.placeholder = @"选择企业";
    [self.enterpriseText.layer setCornerRadius:8.0];
    [self.scrollView addSubview:self.enterpriseText];
    UIView *enterpriseTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.enterpriseText.leftView = enterpriseTextView;
    self.enterpriseText.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.enterpriseText.frame.origin.x, 10, self.enterpriseText.frame.size.width, 35);
    [btn addTarget:self action:@selector(chooseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, kDeviceWidth, 1)];
    labelLine.backgroundColor = BackgroundBlack;
    [self.scrollView addSubview:labelLine];
    
    self.basicTopChooseEnterpriseView = [[NSBundle mainBundle] loadNibNamed:@"BasicTopChooseEnterpriseView" owner:nil options:nil][0];
    self.basicTopChooseEnterpriseView.frame = CGRectMake(0, 56, kDeviceWidth - 10, 355);
    self.basicTopChooseEnterpriseView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.basicTopChooseEnterpriseView];
    
    self.addEnterpriseBottomView = [[NSBundle mainBundle] loadNibNamed:@"AddEnterpriseBottomView" owner:nil options:nil][0];
    self.addEnterpriseBottomView.frame = CGRectMake(0, self.basicTopChooseEnterpriseView.frame.origin.y + self.basicTopChooseEnterpriseView.frame.size.height, kDeviceWidth - 10, 345);
    self.addEnterpriseBottomView.backgroundColor = [UIColor whiteColor];
    [self.addEnterpriseBottomView setAllowAddEnterpriseBottomView];
    [self.scrollView addSubview:self.addEnterpriseBottomView];
    
    [self.addEnterpriseBottomView.switchBtn addTarget:self action:@selector(switchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.addEnterpriseBottomView.switchBtn.selected = NO;

    [self.addEnterpriseBottomView.coordinatesBtn addTarget:self action:@selector(coordinatesBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *tijiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiaoBtn.frame = CGRectMake(40, self.scrollView.frame.origin.y + self.scrollView.frame.size.height + 20, kDeviceWidth - 80, 50);
    [tijiaoBtn addTarget:self action:@selector(tijiaoBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [tijiaoBtn.layer setCornerRadius:8.0];
    [tijiaoBtn setTitle:@"提交并更新环评企业档案" forState:UIControlStateNormal];
    tijiaoBtn.backgroundColor = TabbarBlack_S;
    [tijiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tijiaoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:tijiaoBtn];
}

- (void)chooseBtnAction {
    HomeSearchViewController *homeSearchVC = [[HomeSearchViewController alloc] init];
    [homeSearchVC setBlock:^(NSDictionary * _Nonnull dic) {
        self.enterpriseText.text = [NSString stringWithFormat:@"%@", dic[@"enterpriseName"]];
        [self setNetDetail:self.enterpriseText.text];
    }];
    homeSearchVC.type = @"chooseCompany";
    [self.navigationController pushViewController:homeSearchVC animated:YES];
}

- (void)switchBtnAction {
    if (self.addEnterpriseBottomView.switchBtn.selected == NO) {
        self.addEnterpriseBottomView.switchBtn.selected = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentSize = CGSizeMake(0, 401);
            self.basicTopChooseEnterpriseView.frame = CGRectMake(5, 56, kDeviceWidth - 10, 0);
            [self.scrollView addSubview:self.basicTopChooseEnterpriseView];
            self.addEnterpriseBottomView.frame = CGRectMake(5, self.basicTopChooseEnterpriseView.frame.origin.y + self.basicTopChooseEnterpriseView.frame.size.height, kDeviceWidth - 10, 345);
            [self.scrollView addSubview:self.addEnterpriseBottomView];
            [self.addEnterpriseBottomView.switchBtn setTitle:@"展开详情注册信息" forState:UIControlStateNormal];
        }];
    } else if (self.addEnterpriseBottomView.switchBtn.selected == YES) {
        self.addEnterpriseBottomView.switchBtn.selected = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentSize = CGSizeMake(0, 756);
            self.basicTopChooseEnterpriseView.frame = CGRectMake(5, 56, kDeviceWidth - 10, 355);
            [self.scrollView addSubview:self.basicTopChooseEnterpriseView];
            self.addEnterpriseBottomView.frame = CGRectMake(5, self.basicTopChooseEnterpriseView.frame.origin.y + self.basicTopChooseEnterpriseView.frame.size.height, kDeviceWidth - 10, 345);
            [self.scrollView addSubview:self.addEnterpriseBottomView];
            [self.addEnterpriseBottomView.switchBtn setTitle:@"收起详情注册信息" forState:UIControlStateNormal];
        }];
    }
}

- (void)coordinatesBtnAction {
    if ([IsBlankString isBlankString:self.addEnterpriseBottomView.addressText.text] == NO) {
        MapViewController *mapVC = [[MapViewController alloc] init];
        mapVC.searchStr = self.addEnterpriseBottomView.addressText.text;
        mapVC.locationCity = self.cityName;
        [mapVC setBlock:^(NSString * _Nonnull latitude, NSString * _Nonnull longitude) {
            self.latitude = latitude;
            self.longitude = longitude;
            self.addEnterpriseBottomView.coordinatesText.text = [NSString stringWithFormat:@"(%@, %@)", latitude, longitude];
        }];
        [self.navigationController pushViewController:mapVC animated:YES];
    } else {
        [SVProgressHUD showInfoWithStatus:@"请填写企业地址!"];
    }
}

- (void)tijiaoBtnAction {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([IsBlankString isBlankString:self.basicTopChooseEnterpriseView.enterpriseNameLabel.text] == NO) {
        [dic setObject:self.basicTopChooseEnterpriseView.enterpriseNameLabel.text forKey:@"enterpriseName"];
    }
    
    if ([IsBlankString isBlankString:self.basicTopChooseEnterpriseView.nameLabel.text] == NO) {
        [dic setObject:self.basicTopChooseEnterpriseView.nameLabel.text forKey:@"legalManName"];
    }
    
    if ([IsBlankString isBlankString:self.basicTopChooseEnterpriseView.moneyLabel.text] == NO) {
        [dic setObject:self.basicTopChooseEnterpriseView.moneyLabel.text forKey:@"injection"];
    }
    
    if ([IsBlankString isBlankString:self.basicTopChooseEnterpriseView.creditCodeLabel.text] == NO) {
        [dic setObject:self.basicTopChooseEnterpriseView.creditCodeLabel.text forKey:@"creditCode"];
    }
    
    if ([IsBlankString isBlankString:self.basicTopChooseEnterpriseView.taxIdNumberLabel.text] == NO) {
        [dic setObject:self.basicTopChooseEnterpriseView.taxIdNumberLabel.text forKey:@"taxNumber"];
    }
    
    if ([IsBlankString isBlankString:self.basicTopChooseEnterpriseView.organizationCodeLabel.text] == NO) {
        [dic setObject:self.basicTopChooseEnterpriseView.organizationCodeLabel.text forKey:@"agencyCode"];
    }
    
    if ([IsBlankString isBlankString:self.basicTopChooseEnterpriseView.registrationLabel.text] == NO) {
        [dic setObject:self.basicTopChooseEnterpriseView.registrationLabel.text forKey:@"registerOrgan"];
    }
    
    if ([IsBlankString isBlankString:self.basicTopChooseEnterpriseView.addressLabel.text] == NO) {
        [dic setObject:self.basicTopChooseEnterpriseView.addressLabel.text forKey:@"qccDivision"];
    }
    
    if ([IsBlankString isBlankString:self.addEnterpriseBottomView.addressText.text] == NO) {
        [dic setObject:self.addEnterpriseBottomView.addressText.text forKey:@"qccRegisterAddress"];
    }
    
    if ([IsBlankString isBlankString:self.addEnterpriseBottomView.contactNameText.text] == NO) {
        [dic setObject:self.addEnterpriseBottomView.contactNameText.text forKey:@"contactName"];
    }
    
    if ([IsBlankString isBlankString:self.addEnterpriseBottomView.addressText.text] == NO) {
        [dic setObject:self.addEnterpriseBottomView.addressText.text forKey:@"cpyObjAddress"];
    }
    
    if ([IsBlankString isBlankString:self.longitude] == NO) {
        [dic setObject:self.longitude forKey:@"longitude"];
        [dic setObject:self.latitude forKey:@"latitude"];
    }
    
    if ([IsBlankString isBlankString:self.addEnterpriseBottomView.flagMake] == NO) {
        [dic setObject:self.addEnterpriseBottomView.flagMake forKey:@"flagMake"];
    }
    
    if ([IsBlankString isBlankString:self.addEnterpriseBottomView.phoneText.text] == NO) {
        if ([XYCommon isMobileNumber:self.addEnterpriseBottomView.phoneText.text] == NO) {
            [SVProgressHUD showInfoWithStatus:@"请填写正确的手机号码!"];
        } else {
            [dic setObject:self.addEnterpriseBottomView.phoneText.text forKey:@"contactPhone"];
            [self setCreateNet:dic];
        }
    } else {
        [self setCreateNet:dic];
    }
}

- (void)setCreateNet:(NSMutableDictionary *)dic {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"提交中...";
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"enterprise/create") parameters:@{@"entity":dic} view:self completion:^(id result) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([result[@"isSuccess"] intValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [SVProgressHUD showInfoWithStatus:result[@"message"]];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)setNetDetail:(NSString *)name {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"enterprise/qicha2cpydetail") parameters:@{@"entity":@{@"enterpriseName":name}} view:self completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            if ([[result[@"result"] allKeys] containsObject:@"enterpriseName"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"result"][@"enterpriseName"]]] == NO) {
                self.basicTopChooseEnterpriseView.enterpriseNameLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"enterpriseName"]];
            }
            
            if ([[result[@"result"] allKeys] containsObject:@"legalManName"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"result"][@"legalManName"]]] == NO) {
                self.basicTopChooseEnterpriseView.nameLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"legalManName"]];
            }
            
            if ([[result[@"result"] allKeys] containsObject:@"injection"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"result"][@"injection"]]] == NO) {
                self.basicTopChooseEnterpriseView.moneyLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"injection"]];
            }
            
            if ([[result[@"result"] allKeys] containsObject:@"creditCode"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"result"][@"creditCode"]]] == NO) {
                self.basicTopChooseEnterpriseView.creditCodeLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"creditCode"]];
            }
            
            if ([[result[@"result"] allKeys] containsObject:@"taxNumber"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"result"][@"taxNumber"]]] == NO) {
                self.basicTopChooseEnterpriseView.taxIdNumberLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"taxNumber"]];
            }
            
            if ([[result[@"result"] allKeys] containsObject:@"agencyCode"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"result"][@"agencyCode"]]] == NO) {
                self.basicTopChooseEnterpriseView.organizationCodeLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"agencyCode"]];
            }
            
            if ([[result[@"result"] allKeys] containsObject:@"registerOrgan"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"result"][@"registerOrgan"]]] == NO) {
                self.basicTopChooseEnterpriseView.registrationLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"registerOrgan"]];
            }
            
            if ([[result[@"result"] allKeys] containsObject:@"qccRegisterAddress"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"result"][@"qccRegisterAddress"]]] == NO) {
                self.basicTopChooseEnterpriseView.addressLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"qccRegisterAddress"]];
                self.addEnterpriseBottomView.regionText.text = [NSString stringWithFormat:@"%@", result[@"result"][@"qccRegisterAddress"]];
                self.addEnterpriseBottomView.addressText.text = [NSString stringWithFormat:@"%@", result[@"result"][@"qccRegisterAddress"]];
                if ([[NSString stringWithFormat:@"%@", result[@"result"][@"qccRegisterAddress"]] containsString:@"省"]) {
                    NSArray *array = [self.addEnterpriseBottomView.addressText.text componentsSeparatedByString:@"省"];
                    NSString *str1 = array[1];
                    NSArray *array2 = [str1 componentsSeparatedByString:@"市"];
                    self.cityName = [NSString stringWithFormat:@"%@市", array2[0]];
                } else {
                    NSArray *array = [self.addEnterpriseBottomView.addressText.text componentsSeparatedByString:@"市"];
                    self.cityName = [NSString stringWithFormat:@"%@市", array[0]];
                }
            }
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"message"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
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
