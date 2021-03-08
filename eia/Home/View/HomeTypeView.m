//
//  HomeTypeView.m
//  eia
//
//  Created by JimmyYue on 2020/4/28.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "HomeTypeView.h"

@implementation HomeTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)parkBtnAction:(id)sender {  // 园区
    ParkManagementViewController *parkVC = [[ParkManagementViewController alloc] init];
    parkVC.hidesBottomBarWhenPushed = YES;
    [self.view.navigationController pushViewController:parkVC animated:YES];
}

- (IBAction)learnBtnAction:(id)sender {  // 学习文件
    HomeMapViewController *mapVC = [[HomeMapViewController alloc] init];
    mapVC.hidesBottomBarWhenPushed = YES;
    [self.view.navigationController pushViewController:mapVC animated:YES];
//    [SVProgressHUD showErrorWithStatus:@"此功能开发中 !"];
}

- (IBAction)addEnterpriseAction:(id)sender {  // 建档
    AddEnterpriseViewController *addVC = [[AddEnterpriseViewController alloc] init];
    addVC.hidesBottomBarWhenPushed = YES;
    [self.view.navigationController pushViewController:addVC animated:YES];
}

- (IBAction)addProductionAction:(id)sender {  // 环保咨询
    [SVProgressHUD showErrorWithStatus:@"此功能开发中 !"];
}

- (IBAction)draftBtnAction:(id)sender {  // 巡查计划
    PatrolPlanViewController *tourVC = [[PatrolPlanViewController alloc] init];
    tourVC.hidesBottomBarWhenPushed = YES;
    [self.view.navigationController pushViewController:tourVC animated:YES];
}

- (IBAction)classificationBtnAction:(id)sender {
    ChooseIndustryViewController *industryClassificationVC = [[ChooseIndustryViewController alloc] init];
    industryClassificationVC.titleStr = @"国家分类管理名录查询";
    industryClassificationVC.hidesBottomBarWhenPushed = YES;
    [self.view.navigationController pushViewController:industryClassificationVC animated:YES];
}

@end
