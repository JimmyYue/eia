//
//  UpdateBasicInformationViewController.m
//  eia
//
//  Created by JimmyYue on 2020/6/23.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "UpdateBasicInformationViewController.h"

@interface UpdateBasicInformationViewController ()

@end

@implementation UpdateBasicInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"基本信息";
    self.view.backgroundColor = BackgroundBlack;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 1, kDeviceWidth - 10, kDeviceHeight - NavRect - StatusRect - 90)];
    scrollView.backgroundColor = BackgroundBlack;
    scrollView.contentSize = CGSizeMake(0, 355 + 850);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    self.basicTopChooseEnterpriseView = [[NSBundle mainBundle] loadNibNamed:@"BasicTopChooseEnterpriseView" owner:nil options:nil][0];
    self.basicTopChooseEnterpriseView.frame = CGRectMake(0, 0, kDeviceWidth - 10, 355);
    self.basicTopChooseEnterpriseView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:self.basicTopChooseEnterpriseView];
    
    if ([[self.dicDetail allKeys] containsObject:@"enterpriseName"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.dicDetail[@"enterpriseName"]]] == NO) {
        self.basicTopChooseEnterpriseView.enterpriseNameLabel.text = [NSString stringWithFormat:@"%@", self.dicDetail[@"enterpriseName"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"legalManName"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.dicDetail[@"legalManName"]]] == NO) {
        self.basicTopChooseEnterpriseView.nameLabel.text = [NSString stringWithFormat:@"%@", self.dicDetail[@"legalManName"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"injection"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.dicDetail[@"injection"]]] == NO) {
        self.basicTopChooseEnterpriseView.moneyLabel.text = [NSString stringWithFormat:@"%@", self.dicDetail[@"injection"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"creditCode"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.dicDetail[@"creditCode"]]] == NO) {
        self.basicTopChooseEnterpriseView.creditCodeLabel.text = [NSString stringWithFormat:@"%@", self.dicDetail[@"creditCode"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"taxNumber"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.dicDetail[@"taxNumber"]]] == NO) {
        self.basicTopChooseEnterpriseView.taxIdNumberLabel.text = [NSString stringWithFormat:@"%@", self.dicDetail[@"taxNumber"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"agencyCode"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.dicDetail[@"agencyCode"]]] == NO) {
        self.basicTopChooseEnterpriseView.organizationCodeLabel.text = [NSString stringWithFormat:@"%@", self.dicDetail[@"agencyCode"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"registerOrgan"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.dicDetail[@"registerOrgan"]]] == NO) {
        self.basicTopChooseEnterpriseView.registrationLabel.text = [NSString stringWithFormat:@"%@", self.dicDetail[@"registerOrgan"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"qccRegisterAddress"] || [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.dicDetail[@"qccRegisterAddress"]]] == NO) {
        self.basicTopChooseEnterpriseView.addressLabel.text = [NSString stringWithFormat:@"%@", self.dicDetail[@"qccRegisterAddress"]];
    }
    
    self.noProductionView = [[NSBundle mainBundle] loadNibNamed:@"NoProductionView" owner:nil options:nil][0];
    self.noProductionView.frame = CGRectMake(0, self.basicTopChooseEnterpriseView.frame.size.height + self.basicTopChooseEnterpriseView.frame.origin.y, kDeviceWidth - 10, 850);
    self.noProductionView.backgroundColor = [UIColor whiteColor];
    self.noProductionView.view = self;
    [self.noProductionView setAllowNoProductionView:self.dicDetail];
    [scrollView addSubview:self.noProductionView];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updateBtn.frame = CGRectMake(30, scrollView.frame.origin.y + scrollView.frame.size.height + 20, kDeviceWidth - 60, 50);
    [updateBtn addTarget:self action:@selector(updateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [updateBtn.layer setCornerRadius:8.0];
    [updateBtn setTitle:@"提交并更新企业档案" forState:UIControlStateNormal];
    updateBtn.backgroundColor = TabbarBlack_S;
    [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:updateBtn];
}

- (void)updateBtnAction {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"%@", self.dicDetail[@"id"]]  forKey:@"id"];
    if ([IsBlankString isBlankString:self.noProductionView.parkCode] == NO) {
        [dic setObject:self.noProductionView.parkCode forKey:@"parkCode"];
        [dic setObject:self.noProductionView.parkNameText.text  forKey:@"parkName"];
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.taxBeginText.text] == NO) {
        [dic setObject:self.noProductionView.taxBeginText.text  forKey:@"taxBegin"];
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.taxEndText.text] == NO) {
        [dic setObject:self.noProductionView.taxEndText.text forKey:@"taxEnd"];
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.contactText.text] == NO) {
        [dic setObject:self.noProductionView.contactText.text forKey:@"contactName"];
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.phoneText.text] == NO) {
        [dic setObject:self.noProductionView.phoneText.text forKey:@"contactPhone"];
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.timeText.text] == NO) {
        [dic setObject:self.noProductionView.timeText.text forKey:@"enterDate"];
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.addressSText.text] == NO) {
        [dic setObject:self.noProductionView.addressSText.text forKey:@"cpyObjAddress"];
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.longitude] == NO) {
        [dic setObject:self.noProductionView.longitude forKey:@"longitude"];
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.latitude] == NO) {
        [dic setObject:self.noProductionView.latitude forKey:@"latitude"];
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.engageType] == NO) {
        [dic setObject:self.noProductionView.engageType forKey:@"engageType"];
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.areaText.text] == NO) {
        [dic setObject:self.noProductionView.areaText.text forKey:@"plantArea"];
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.plantUseType] == NO) {
        [dic setObject:self.noProductionView.plantUseType forKey:@"plantUseType"];
    }
    
    if ([self.noProductionView.plantUseType isEqualToString:@"rent"]) {
        if ([IsBlankString isBlankString:self.noProductionView.landlordText.text] == NO) {
            [dic setObject:self.noProductionView.landlordText.text forKey:@"landlordName"];
        }
    }
    
    if ([IsBlankString isBlankString:self.noProductionView.text.text] == NO) {
        [dic setObject:self.noProductionView.text.text forKey:@"situation"];
    }
    
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       hud.label.text = @"提交中...";
       
       [NetworkHandler requestPostWithUrl:API_BASE_URL(@"enterprise/update") parameters:@{@"entity":dic} view:nil completion:^(id result) {
           
           if ([result[@"isSuccess"] intValue] == 1) {
               
               self.reloadBlock(@"success");
               [self.navigationController popViewControllerAnimated:YES];
               
           } else {
               [SVProgressHUD showInfoWithStatus:result[@"message"]];
           }
           
           [MBProgressHUD hideHUDForView:self.view animated:YES];
       } failure:^(NSError *error) {
           NSLog(@"%@", error);
           [MBProgressHUD hideHUDForView:self.view animated:YES];
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
