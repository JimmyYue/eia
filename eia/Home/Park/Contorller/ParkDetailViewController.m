//
//  ParkDetailViewController.m
//  eia
//
//  Created by JimmyYue on 2020/4/29.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "ParkDetailViewController.h"

@interface ParkDetailViewController ()

@end

@implementation ParkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"园区详情";
    self.view.backgroundColor = BackgroundBlack;
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton setTitle:@"修改" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self setNetDetail];
}

- (void)rightBtnAction {
    NewParkViewController *addVC = [[NewParkViewController alloc] init];
    addVC.type = @"detail";
    addVC.detailDic = self.detailDic;
    [addVC setBlock:^(NSDictionary * _Nonnull dic) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@", dic[@"parkName"]];
        self.typeLabel.text = [NSString stringWithFormat:@"%@", dic[@"lotTypeName"]];
        if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"streetName"]]] == NO) {
            self.addressLabel.text = [NSString stringWithFormat:@"行政区域 : %@%@%@", dic[@"cityName"], dic[@"regionName"], dic[@"streetName"]];
        } else {
            self.addressLabel.text = [NSString stringWithFormat:@"行政区域 : %@%@", dic[@"cityName"], dic[@"regionName"]];
        }
        self.block(dic);
    }];
    [self.navigationController pushViewController:addVC animated:YES];
}


- (void)setNetDetail {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"加载中...";
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"townpark/detail") parameters:@{@"entity":@{@"id":self.parkCode}} view:self completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.detailDic = [[NSDictionary alloc] init];
            self.detailDic = result[@"result"];
            
            self.titleLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"parkName"]];
            
            self.typeLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"lotTypeName"]];
            
            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"result"][@"streetName"]]] == NO) {
                self.addressLabel.text = [NSString stringWithFormat:@"行政区域 : %@%@%@", result[@"result"][@"cityName"], result[@"result"][@"regionName"], result[@"result"][@"streetName"]];
            } else {
                self.addressLabel.text = [NSString stringWithFormat:@"行政区域 : %@%@", result[@"result"][@"cityName"], result[@"result"][@"regionName"]];
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
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
