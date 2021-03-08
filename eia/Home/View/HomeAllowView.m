//
//  HomeAllowView.m
//  eia
//
//  Created by JimmyYue on 2020/9/25.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "HomeAllowView.h"

@implementation HomeAllowView

- (void)setHomeAllowView {
    
    self.dataView.layer.shadowColor = TabbarBlack.CGColor;
    self.dataView.layer.shadowOffset = CGSizeMake(0, 6);
    self.dataView.layer.shadowOpacity = 0.4;
    self.dataView.layer.shadowRadius = 6;
    
    self.inputtingBtn.layer.shadowColor = TabbarBlack.CGColor;
    self.inputtingBtn.layer.shadowOffset = CGSizeMake(0, 6);
    self.inputtingBtn.layer.shadowOpacity = 0.4;
    self.inputtingBtn.layer.shadowRadius = 6;
    
    self.parkBtn.layer.shadowColor = TabbarBlack.CGColor;
    self.parkBtn.layer.shadowOffset = CGSizeMake(0, 6);
    self.parkBtn.layer.shadowOpacity = 0.4;
    self.parkBtn.layer.shadowRadius = 6;
    
    self.learnBtn.layer.shadowColor = TabbarBlack.CGColor;
    self.learnBtn.layer.shadowOffset = CGSizeMake(0, 6);
    self.learnBtn.layer.shadowOpacity = 0.4;
    self.learnBtn.layer.shadowRadius = 6;
    
    self.consultingBtn.layer.shadowColor = TabbarBlack.CGColor;
    self.consultingBtn.layer.shadowOffset = CGSizeMake(0, 6);
    self.consultingBtn.layer.shadowOpacity = 0.4;
    self.consultingBtn.layer.shadowRadius = 6;
    
    self.classificationBtn.layer.shadowColor = TabbarBlack.CGColor;
    self.classificationBtn.layer.shadowOffset = CGSizeMake(0, 6);
    self.classificationBtn.layer.shadowOpacity = 0.4;
    self.classificationBtn.layer.shadowRadius = 6;
    
    self.planBtn.layer.shadowColor = TabbarBlack.CGColor;
    self.planBtn.layer.shadowOffset = CGSizeMake(0, 6);
    self.planBtn.layer.shadowOpacity = 0.4;
    self.planBtn.layer.shadowRadius = 6;
    
    self.pieChartViewF = [[CJPieChartView alloc] initWithFrame:CGRectMake(50, 110, 100, 100) centerTitle:@"100%"];
    self.pieChartViewF.backgroundColor = [UIColor whiteColor];
    self.pieChartViewF.layerPieData =  @[[CJPieChartModel modelWithStart:0.f end:1.0f color:RGBCOLOR(45, 113, 121)]];
    self.pieChartViewF.cj_delegate = self;
    self.pieChartViewF.centerTitleColor = [UIColor whiteColor];
    self.pieChartViewF.pieHoopWidth = 30.0f;
    self.pieChartViewF.pieChartType = CJPieNormalChart;
    self.pieChartViewF.pieChartSelectStyle = CJPieChartSelectStyleStrike;
    self.pieChartViewF.pieChartShowStyle = CJPieChartShowStyleJagged;
    self.pieChartViewF.jagWidth = 10.0f;
    [self addSubview:self.pieChartViewF];
    
}


- (IBAction)inputtingBtnAction:(id)sender {
    AddEnterpriseViewController *addVC = [[AddEnterpriseViewController alloc] init];
    addVC.hidesBottomBarWhenPushed = YES;
    [self.controller.navigationController pushViewController:addVC animated:YES];
}

- (IBAction)parkBtnAction:(id)sender {
    ParkManagementViewController *parkVC = [[ParkManagementViewController alloc] init];
    parkVC.hidesBottomBarWhenPushed = YES;
    [self.controller.navigationController pushViewController:parkVC animated:YES];
}

- (IBAction)learnBtnAction:(id)sender {
    [SVProgressHUD showInfoWithStatus:@"开发中!"];
}

- (IBAction)consultingBtnAction:(id)sender {
    [SVProgressHUD showInfoWithStatus:@"开发中!"];
}

- (IBAction)classificationBtnAction:(id)sender {
    [SVProgressHUD showInfoWithStatus:@"开发中!"];
}

- (IBAction)planBtnAction:(id)sender {
    PatrolPlanViewController *tourVC = [[PatrolPlanViewController alloc] init];
    tourVC.hidesBottomBarWhenPushed = YES;
    [self.controller.navigationController pushViewController:tourVC animated:YES];
}

- (void)setNetHome {
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.label.text = @"加载中...";
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"bingtu/countCheckRate") parameters:@{@"entity":@{}} view:self.controller completion:^(id result) {
        
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            float normal = 0.0; // 合规
            float commonEdit = 0.0;  // 整改
            float focusEdit = 0.0;  // 风险
            float totalNumber = [result[@"result"][@"totalNumber"] floatValue];  // 总数
            
            for (int i = 0; i < [result[@"result"][@"bingFenEntityList"] count]; i++) {
                if ([[NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"bingTuType"]] isEqualToString:@"focusEdit"]) {
                    self.focusEditCountLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"countNumber"]];
                    focusEdit = [result[@"result"][@"bingFenEntityList"][i][@"countNumber"] floatValue];
                } else if ([[NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"bingTuType"]] isEqualToString:@"commonEdit"]) {
                    self.commonEditCountLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"countNumber"]];
                    commonEdit = [result[@"result"][@"bingFenEntityList"][i][@"countNumber"] floatValue];
                } else if ([[NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"bingTuType"]] isEqualToString:@"normal"]) {
                    self.normalCountLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"countNumber"]];
                    normal = [result[@"result"][@"bingFenEntityList"][i][@"countNumber"] floatValue];
                }
            }
            if (totalNumber > 0) {
                self.pieChartViewF.layerPieData =  @[[CJPieChartModel modelWithStart:0.f end:focusEdit / totalNumber color:RGBCOLOR(236, 40, 1)],
                                                     [CJPieChartModel modelWithStart:focusEdit / totalNumber end:focusEdit / totalNumber +  (commonEdit / totalNumber) color:RGBCOLOR(252, 96, 28)],
                                                     [CJPieChartModel modelWithStart:focusEdit / totalNumber +  (commonEdit / totalNumber) end:1.00f color:RGBCOLOR(45, 113, 121)]];
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpRelationTourPlan/todayData") parameters:@{} view:self.controller completion:^(id result) {
        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([result[@"isSuccess"] intValue] == 1) {
            for (int i = 0; i < [result[@"result"] count]; i++) {
                if ([[NSString stringWithFormat:@"%@", result[@"result"][i][@"tourPlanStatus"]] isEqualToString:@"finish"]) {
                    self.finishLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][i][@"tourPlanStatusCount"]];
                } else if ([[NSString stringWithFormat:@"%@", result[@"result"][i][@"tourPlanStatus"]] isEqualToString:@"patrol"]) {
                    self.patrolLabel.text = [NSString stringWithFormat:@"今日计划 : %@", result[@"result"][i][@"tourPlanStatusCount"]];
                }
            }
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
