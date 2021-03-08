//
//  NewParkViewController.m
//  eia
//
//  Created by JimmyYue on 2020/4/24.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "NewParkViewController.h"

@interface NewParkViewController ()

@end

@implementation NewParkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self.type isEqualToString:@"add"] || [self.type isEqualToString:@"choosePark"]) {
        self.title = @"新增园区";
        self.firstBtn.selected = YES;
        self.firstBtn.backgroundColor = TabbarBlack_S;
        self.chooseBtn = self.firstBtn;
        self.lotType = @"land104";
        [self.addBtn setTitle:@"确定" forState:UIControlStateNormal];
    } else {
        self.title = @"园区详情";
        self.parkNameText.text = [NSString stringWithFormat:@"%@", self.detailDic[@"parkName"]];
        if ([[self.detailDic allKeys] containsObject:@"cityName"]) {
            self.cityName = self.detailDic[@"cityName"];
            self.cityCode = self.detailDic[@"cityCode"];
        }
        if ([[self.detailDic allKeys] containsObject:@"regionName"]) {
            self.regionName = self.detailDic[@"regionName"];
            self.regionCode = self.detailDic[@"regionCode"];
        }
        if ([[self.detailDic allKeys] containsObject:@"streetName"]) {
            self.streetName = self.detailDic[@"streetName"];
            self.streetCode = self.detailDic[@"streetCode"];
        }
        self.lotType = [NSString stringWithFormat:@"%@", self.detailDic[@"lotType"]];
        
        self.regionBtn.backgroundColor = [UIColor whiteColor];
        if ([[self.detailDic allKeys] containsObject:@"streetName"]) {
            [self.regionBtn setTitle:[NSString stringWithFormat:@"%@%@%@", self.detailDic[@"cityName"], self.detailDic[@"regionName"], self.detailDic[@"streetName"]] forState:UIControlStateNormal];
        } else {
            [self.regionBtn setTitle:[NSString stringWithFormat:@"%@%@", self.detailDic[@"cityName"], self.detailDic[@"regionName"]] forState:UIControlStateNormal];
        }
        
        self.lotType = self.detailDic[@"lotType"];
        if ([[NSString stringWithFormat:@"%@", self.detailDic[@"lotTypeName"]] isEqualToString:self.firstBtn.titleLabel.text]) {
            self.firstBtn.selected = YES;
            self.firstBtn.backgroundColor = TabbarBlack_S;
            self.chooseBtn = self.firstBtn;
        } else if ([[NSString stringWithFormat:@"%@", self.detailDic[@"lotTypeName"]] isEqualToString:self.secondBtn.titleLabel.text]) {
            self.secondBtn.selected = YES;
            self.secondBtn.backgroundColor = TabbarBlack_S;
            self.chooseBtn = self.secondBtn;
        } else if ([[NSString stringWithFormat:@"%@", self.detailDic[@"lotTypeName"]] isEqualToString:self.thirdBtn.titleLabel.text]) {
            self.thirdBtn.selected = YES;
            self.thirdBtn.backgroundColor = TabbarBlack_S;
            self.chooseBtn = self.thirdBtn;
        } else if ([[NSString stringWithFormat:@"%@", self.detailDic[@"lotTypeName"]] isEqualToString:self.otherBtn.titleLabel.text]) {
            self.otherBtn.selected = YES;
            self.otherBtn.backgroundColor = TabbarBlack_S;
            self.chooseBtn = self.otherBtn;
        }
    }
    self.view.backgroundColor = BackgroundBlack;
    
    UIView *ptextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.parkNameText.leftView = ptextView;
    self.parkNameText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rtextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.regionText.leftView = rtextView;
    self.regionText.leftViewMode = UITextFieldViewModeAlways;
    
    self.cityPicker = [[CityPicker alloc] initWithFrame:CGRectMake(0, kDeviceHeight - StatusRect, kDeviceWidth, kDeviceHeight - StatusRect)];
    self.cityPicker.level = 4;
    self.cityPicker.delegate = self;
    [self.view addSubview:self.cityPicker];
    
}

- (IBAction)regionBtnAction:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        //  时间内执行的代码
        self.cityPicker.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - StatusRect);
    }];
    
//    ChooseLocationViewController *chooseVC = [[ChooseLocationViewController alloc] init];
//    chooseVC.chooseLevel = @"street";
//    [chooseVC setBlock:^(NSDictionary * _Nonnull dic) {
//        if (dic.count > 0) {
//            if ([[dic allKeys] containsObject:@"cityName"]) {
//                self.cityName = dic[@"cityName"];
//                self.cityCode = dic[@"city"];
//            }
//            if ([[dic allKeys] containsObject:@"regionName"]) {
//                self.regionName = dic[@"regionName"];
//                self.regionCode = dic[@"region"];
//            }
//            if ([[dic allKeys] containsObject:@"streetName"]) {
//                self.streetName = dic[@"streetName"];
//                self.streetCode = dic[@"street"];
//            } else {
//                self.streetName = @"";
//                self.streetCode = @"";
//            }
//        }
//        
//        NSArray *addressArray = @[[NSString stringWithFormat:@"%@", dic[@"regionName"]], [NSString stringWithFormat:@"%@", dic[@"streetName"]], [NSString stringWithFormat:@"%@", dic[@"communityName"]]];
//        NSString *address = [NSString stringWithFormat:@"%@", dic[@"cityName"]];
//        for (int i = 0; i < addressArray.count; i++) {
//            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", addressArray[i]]] == NO) {
//                address = [NSString stringWithFormat:@"%@%@", address, addressArray[i]];
//            }
//        }
//        self.regionBtn.backgroundColor = [UIColor whiteColor];
//        [self.regionBtn setTitle:address forState:UIControlStateNormal];
//    }];
//    [self.navigationController pushViewController:chooseVC animated:YES];
}
    
- (void)setDic:(CityPicker *)view dic:(NSMutableDictionary *)pickerDic {
    
    NSLog(@"%@", pickerDic);
    
    self.provinceName = [NSString stringWithFormat:@"%@", [pickerDic objectForKey:@"provinceName"]];
    self.provinceCode = [NSString stringWithFormat:@"%@", [pickerDic objectForKey:@"provinceCode"]];
    self.cityName = [NSString stringWithFormat:@"%@", [pickerDic objectForKey:@"cityName"]];
    self.cityCode = [NSString stringWithFormat:@"%@", [pickerDic objectForKey:@"cityCode"]];
    self.regionName = [NSString stringWithFormat:@"%@", [pickerDic objectForKey:@"regionName"]];
    self.regionCode = [NSString stringWithFormat:@"%@", [pickerDic objectForKey:@"regionCode"]];
    self.streetName = [NSString stringWithFormat:@"%@", [pickerDic objectForKey:@"streetName"]];
    self.streetCode = [NSString stringWithFormat:@"%@", [pickerDic objectForKey:@"streetCode"]];
    
    self.regionText.text = [NSString stringWithFormat:@"%@-%@-%@-%@", self.provinceName, self.cityName, self.regionName, self.streetName];
}

- (void)setHidden:(CityPicker *)view {
    [UIView animateWithDuration:0.5 animations:^{
        //  时间内执行的代码
        self.cityPicker.frame = CGRectMake(0, kDeviceHeight - StatusRect, kDeviceWidth, kDeviceHeight - StatusRect);
    }];
}

- (IBAction)btnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.chooseBtn != button) {
        self.chooseBtn.selected = NO;
        self.chooseBtn.backgroundColor = RGBCOLOR(240, 240, 240);
        self.chooseBtn = button;
        button.selected = YES;
        self.chooseBtn.backgroundColor = TabbarBlack_S;
        
        if (button.tag == 300) {
            self.lotType = @"land104";
        } else if (button.tag == 301) {
            self.lotType = @"land195";
        } else if (button.tag == 302) {
            self.lotType = @"land198";
        } else if (button.tag == 303) {
            self.lotType = @"other";
        }
    }
}

- (IBAction)addBtnAction:(id)sender {
    if ([IsBlankString isBlankString:self.parkNameText.text] == NO) {
        if ([IsBlankString isBlankString:self.regionCode] == NO) {
            if ([IsBlankString isBlankString:self.lotType] == NO) {
                [self setNetAdd];
            } else {
                [SVProgressHUD showInfoWithStatus:@"请选择所属地块！"];
            }
        } else {
            [SVProgressHUD showInfoWithStatus:@"请选择行政区域！"];
        }
    } else {
        [SVProgressHUD showInfoWithStatus:@"请填写园区名称！"];
    }
}

- (void)setNetAdd {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"提交中...";
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.parkNameText.text forKey:@"parkName"];
    [dic setObject:self.lotType forKey:@"lotType"];
    [dic setObject:self.cityCode forKey:@"cityCode"];
    [dic setObject:self.cityName forKey:@"cityName"];
    [dic setObject:self.regionCode forKey:@"regionCode"];
    [dic setObject:self.regionName forKey:@"regionName"];
    if ([IsBlankString isBlankString:self.streetName] == NO) {
        [dic setObject:self.streetCode forKey:@"streetCode"];
        [dic setObject:self.streetName forKey:@"streetName"];
    }
    
    NSString *urlStr;
    if ([self.type isEqualToString:@"add"] || [self.type isEqualToString:@"choosePark"]) {
        urlStr = @"townpark/create";
    } else {
        urlStr = @"townpark/update";
        [dic setObject:self.detailDic[@"id"] forKey:@"id"];
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(urlStr) parameters:@{@"entity":dic} view:self completion:^(id result) {
        
        NSLog(@"%@", result);
        
        if ([result[@"isSuccess"] intValue] == 1) {
            if ([self.type isEqualToString:@"add"]) {
                [SVProgressHUD showInfoWithStatus:@"新增能成功, 请到园区管理中查看！"];
                if (self.block != nil) {
                    self.block(result[@"result"]);
                }
            } else if ([self.type isEqualToString:@"choosePark"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NewPark" object:nil userInfo:result[@"result"]];
                
                if (self.navigationController.viewControllers.count > 4) {
                    UIViewController *controller = self.navigationController.viewControllers[2];
                    [self.navigationController popToViewController:controller animated:YES];
                } else {
                    UIViewController *controller = self.navigationController.viewControllers[1];
                    [self.navigationController popToViewController:controller animated:YES];
                }
            } else {
                if (self.block != nil) {
                    self.block(result[@"result"]);
                }
            }
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
