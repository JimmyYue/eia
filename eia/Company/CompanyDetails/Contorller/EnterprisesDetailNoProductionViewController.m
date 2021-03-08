//
//  EnterprisesDetailNoProductionViewController.m
//  eia
//
//  Created by JimmyYue on 2020/7/10.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "EnterprisesDetailNoProductionViewController.h"

@interface EnterprisesDetailNoProductionViewController ()

@end

@implementation EnterprisesDetailNoProductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dicDetail = [[NSMutableDictionary alloc] init];
    [self setDetailNet:@"detail"];  // 详情请求
}

- (void)topBtnAction:(UIButton *)button {
    [UIView animateWithDuration:0.5 animations:^{
        [self setTopView:[[NSString stringWithFormat:@"%ld", button.tag - 300] intValue]];
        self.scrollViewAll.contentOffset = CGPointMake(kDeviceWidth *(button.tag - 300), 0);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.index =  [[NSString stringWithFormat:@"%1.0f", self.scrollViewAll.contentOffset.x] intValue] / [[NSString stringWithFormat:@"%1.0f", self.scrollViewAll.frame.size.width] intValue];
    [self setTopView:self.index];
}

- (void)setTopView:(int)index {
    if (index == 0) {
        [self.enterpriseInformationTopView setFirstSelected];
    } else if (index == 1) {
        [self.enterpriseInformationTopView setSecondSelected];
    } else if (index == 2) {
        [self.enterpriseInformationTopView setThirdSelected];
    } else if (index == 3) {
        [self.enterpriseInformationTopView setFourSelected];
    } else if (index == 4) {
        [self.enterpriseInformationTopView setFiveSelected];
    }
}

- (void)basicAction {
    UpdateBasicInformationViewController *updateBasicInformationVC = [[UpdateBasicInformationViewController alloc] init];
    updateBasicInformationVC.dicDetail = self.dicDetail;
    [updateBasicInformationVC setReloadBlock:^(NSString * _Nonnull type) {
        [self setDetailNet:@"reloadBasic"];
    }];
    [self.navigationController pushViewController:updateBasicInformationVC animated:YES];
}

- (void)eiaAction {
    UpdateEiaViewController *updateEiaVC = [[UpdateEiaViewController alloc] init];
    updateEiaVC.dicDetail = self.dicDetail;
    [updateEiaVC setReloadBlock:^(NSString * _Nonnull type) {
        [self setDetailNet:@"reloadEia"];
    }];
    [self.navigationController pushViewController:updateEiaVC animated:YES];
}

- (void)pollutionAction {
    UpdateSewageViewController *updateSewageVC = [[UpdateSewageViewController alloc] init];
    updateSewageVC.dicDetail = self.dicDetail;
    [updateSewageVC setReloadBlock:^(NSString * _Nonnull type) {
        [self setDetailNet:@"reloadSewage"];
    }];
    [self.navigationController pushViewController:updateSewageVC animated:YES];
}

- (void)imageAction {
    UpdateImageViewController *updateImageVC = [[UpdateImageViewController alloc] init];
    updateImageVC.dicDetail = self.dicDetail;
    [updateImageVC setReloadBlock:^(NSString * _Nonnull type) {
        [self setDetailNet:@"reloadImage"];
    }];
    [self.navigationController pushViewController:updateImageVC animated:YES];
}

- (void)addAction {
    AddPatrolViewController *addVC = [[AddPatrolViewController alloc] init];
    addVC.EtpId = self.Id;
    [addVC setReloadBlock:^(NSString * _Nonnull type) {
        self.basicInformationDetailView.engageTypeNameLabel.text = type;
        [self.patrolRecordView setUpdatePatrolRecordView];
    }];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)setDetailNet:(NSString *)str {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"加载中...";
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"enterprise/detail") parameters:@{@"entity":@{@"id":self.Id}} view:nil completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.title = [NSString stringWithFormat:@"%@", result[@"result"][@"enterpriseName"]];
            
            self.dicDetail = [NSMutableDictionary dictionaryWithDictionary:result[@"result"]];
            
            if ([str isEqualToString:@"detail"]) {
                [self setAllowDetailView:result[@"result"]];
            } else {
                [self setReload:str dic:result[@"result"]];
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"message"]];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)setAllowDetailView:(NSDictionary *)dic {
    
    self.enterpriseInformationTopView = [[NSBundle mainBundle] loadNibNamed:@"EnterpriseInformationTopView" owner:nil options:nil][0];
    self.enterpriseInformationTopView.frame = CGRectMake(0, 0, kDeviceWidth, 70);
    self.enterpriseInformationTopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.enterpriseInformationTopView];
    [self.enterpriseInformationTopView.fBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.enterpriseInformationTopView.sBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.enterpriseInformationTopView.tBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.enterpriseInformationTopView.frBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.enterpriseInformationTopView.fiBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.scrollViewAll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.enterpriseInformationTopView.frame.origin.y + self.enterpriseInformationTopView.frame.size.height, kDeviceWidth, kDeviceHeight - self.enterpriseInformationTopView.frame.origin.y - self.enterpriseInformationTopView.frame.size.height - NavRect - StatusRect)];
    self.scrollViewAll.backgroundColor = [UIColor whiteColor];
    self.scrollViewAll.contentSize = CGSizeMake(kDeviceWidth * 5, 0);
    self.scrollViewAll.showsHorizontalScrollIndicator = NO;//水平滚动条
    self.scrollViewAll.pagingEnabled = YES;
    self.scrollViewAll.bounces = NO;
    self.scrollViewAll.delegate = self;
    [self.view addSubview:self.scrollViewAll];
    
    NSString *str = [NSString stringWithFormat:@"%@", dic[@"situation"]];
    NSDictionary *dicBasic = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGRect rectBasic = [str boundingRectWithSize:CGSizeMake(kDeviceWidth - 110, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicBasic context:nil];
    
    self.basicScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 0, kDeviceWidth - 10, self.scrollViewAll.frame.size.height - 115)];
    self.basicScrollView.backgroundColor = RGBCOLOR(242, 242, 242);
    self.basicScrollView.contentSize = CGSizeMake(0, 615 + rectBasic.size.height);
    self.basicScrollView.backgroundColor = [UIColor whiteColor];
    self.basicScrollView.bounces = NO;
    [self.scrollViewAll addSubview:self.basicScrollView];
    
    self.basicInformationDetailView = [[NSBundle mainBundle] loadNibNamed:@"BasicInformationDetailView" owner:nil options:nil][0];
    self.basicInformationDetailView.frame = CGRectMake(5, 0, kDeviceWidth - 10, 615 + rectBasic.size.height);
    self.basicInformationDetailView.backgroundColor = [UIColor whiteColor];
    [self.basicInformationDetailView setAllowBasicInformationDetailView:dic];
    [self.basicScrollView addSubview:self.basicInformationDetailView];
    
    ParkEnterprisesDetailBottomView *parkEnterprisesDetailBottomViewBasic = [[NSBundle mainBundle] loadNibNamed:@"ParkEnterprisesDetailBottomView" owner:nil options:nil][0];
    parkEnterprisesDetailBottomViewBasic.frame = CGRectMake(5, self.basicScrollView.frame.origin.y + self.basicScrollView.frame.size.height, kDeviceWidth - 10, 100);
    parkEnterprisesDetailBottomViewBasic.backgroundColor = [UIColor whiteColor];
    parkEnterprisesDetailBottomViewBasic.allAddPatrolBtn.hidden = YES;
    parkEnterprisesDetailBottomViewBasic.allAddPatrolBtn.hidden = YES;
    [parkEnterprisesDetailBottomViewBasic.updateBtn setTitle:@"更新 基本信息 档案" forState:UIControlStateNormal];
    parkEnterprisesDetailBottomViewBasic.timeLabel.text = [NSString stringWithFormat:@"企业环保档案最近更新于  %@", [[NSString stringWithFormat:@"%@", dic[@"lastUpdateTime"]] timeToyyyyMMddHHmmssString]];
    [parkEnterprisesDetailBottomViewBasic.updateBtn addTarget:self action:@selector(basicAction) forControlEvents:UIControlEventTouchUpInside];
    [parkEnterprisesDetailBottomViewBasic.addPatrolBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewAll addSubview:parkEnterprisesDetailBottomViewBasic];
    
    
    
    self.eiaScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kDeviceWidth + 5, 0, kDeviceWidth - 10, self.scrollViewAll.frame.size.height - 115)];
    self.eiaScrollView.backgroundColor = BackgroundBlack;
    self.eiaScrollView.contentSize = CGSizeMake(0, 280);
    self.eiaScrollView.bounces = NO;
    [self.scrollViewAll addSubview:self.eiaScrollView];
    
    self.eiaInformationDetailView = [[NSBundle mainBundle] loadNibNamed:@"EiaInformationDetailView" owner:nil options:nil][0];
    self.eiaInformationDetailView.frame = CGRectMake(0, 0, kDeviceWidth - 10, 280);
    self.eiaInformationDetailView.backgroundColor = [UIColor whiteColor];
    [self.eiaInformationDetailView setAllowEiaInformationDetailView:dic];
    [self.eiaScrollView addSubview:self.eiaInformationDetailView];
    
    ParkEnterprisesDetailBottomView *parkEnterprisesDetailBottomViewEia = [[NSBundle mainBundle] loadNibNamed:@"ParkEnterprisesDetailBottomView" owner:nil options:nil][0];
    parkEnterprisesDetailBottomViewEia.frame = CGRectMake(kDeviceWidth + 5, self.eiaScrollView.frame.origin.y + self.eiaScrollView.frame.size.height, kDeviceWidth - 10, 100);
    parkEnterprisesDetailBottomViewEia.backgroundColor = [UIColor whiteColor];
    parkEnterprisesDetailBottomViewEia.allAddPatrolBtn.hidden = YES;
    parkEnterprisesDetailBottomViewEia.allAddPatrolBtn.hidden = YES;
    [parkEnterprisesDetailBottomViewEia.updateBtn setTitle:@"更新 环保信息 档案" forState:UIControlStateNormal];
    parkEnterprisesDetailBottomViewEia.timeLabel.text = [NSString stringWithFormat:@"企业环保档案最近更新于  %@", [[NSString stringWithFormat:@"%@", dic[@"lastUpdateTime"]] timeToyyyyMMddHHmmssString]];
    [parkEnterprisesDetailBottomViewEia.updateBtn addTarget:self action:@selector(eiaAction) forControlEvents:UIControlEventTouchUpInside];
    [parkEnterprisesDetailBottomViewEia.addPatrolBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewAll addSubview:parkEnterprisesDetailBottomViewEia];
    
    
    
    
    self.pollutionDetailView = [[PollutionDetailView alloc] initWithFrame:CGRectMake(kDeviceWidth * 2 + 5, 0, kDeviceWidth - 10, self.scrollViewAll.frame.size.height - 115)];
    self.pollutionDetailView.backgroundColor = BackgroundBlack;
    [self.pollutionDetailView setAllowPollutionDetailView:dic];
    [self.scrollViewAll addSubview:self.pollutionDetailView];
    
    ParkEnterprisesDetailBottomView *parkEnterprisesDetailBottomViewPollution = [[NSBundle mainBundle] loadNibNamed:@"ParkEnterprisesDetailBottomView" owner:nil options:nil][0];
    parkEnterprisesDetailBottomViewPollution.frame = CGRectMake(kDeviceWidth * 2 + 5, self.pollutionDetailView.frame.origin.y + self.pollutionDetailView.frame.size.height, kDeviceWidth - 10, 100);
    parkEnterprisesDetailBottomViewPollution.backgroundColor = [UIColor whiteColor];
    parkEnterprisesDetailBottomViewPollution.allAddPatrolBtn.hidden = YES;
    parkEnterprisesDetailBottomViewPollution.allAddPatrolBtn.hidden = YES;
    [parkEnterprisesDetailBottomViewPollution.updateBtn setTitle:@"更新 排污情况 档案" forState:UIControlStateNormal];
    parkEnterprisesDetailBottomViewPollution.timeLabel.text = [NSString stringWithFormat:@"企业环保档案最近更新于  %@", [[NSString stringWithFormat:@"%@", dic[@"lastUpdateTime"]] timeToyyyyMMddHHmmssString]];
    [parkEnterprisesDetailBottomViewPollution.updateBtn addTarget:self action:@selector(pollutionAction) forControlEvents:UIControlEventTouchUpInside];
    [parkEnterprisesDetailBottomViewPollution.addPatrolBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewAll addSubview:parkEnterprisesDetailBottomViewPollution];
    
    
    
    self.imageInformationView = [[ImageInformationView alloc] initWithFrame:CGRectMake(kDeviceWidth * 3, 0, kDeviceWidth, self.scrollViewAll.frame.size.height - 115)];
    [self.imageInformationView setAllowImageInformationView:dic];
    [self.scrollViewAll addSubview:self.imageInformationView];
    
    ParkEnterprisesDetailBottomView *parkEnterprisesDetailBottomViewImage = [[NSBundle mainBundle] loadNibNamed:@"ParkEnterprisesDetailBottomView" owner:nil options:nil][0];
    parkEnterprisesDetailBottomViewImage.frame = CGRectMake(kDeviceWidth * 3 + 5, self.imageInformationView.frame.origin.y + self.imageInformationView.frame.size.height, kDeviceWidth - 10, 100);
    parkEnterprisesDetailBottomViewImage.backgroundColor = [UIColor whiteColor];
    parkEnterprisesDetailBottomViewImage.allAddPatrolBtn.hidden = YES;
    parkEnterprisesDetailBottomViewImage.allAddPatrolBtn.hidden = YES;
    [parkEnterprisesDetailBottomViewImage.updateBtn setTitle:@"更新 企业图片 档案" forState:UIControlStateNormal];
    parkEnterprisesDetailBottomViewImage.timeLabel.text = [NSString stringWithFormat:@"企业环保档案最近更新于  %@", [[NSString stringWithFormat:@"%@", dic[@"lastUpdateTime"]] timeToyyyyMMddHHmmssString]];
    [parkEnterprisesDetailBottomViewImage.updateBtn addTarget:self action:@selector(imageAction) forControlEvents:UIControlEventTouchUpInside];
    [parkEnterprisesDetailBottomViewImage.addPatrolBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewAll addSubview:parkEnterprisesDetailBottomViewImage];
    
    
    
    self.patrolRecordView = [[PatrolRecordView alloc] initWithFrame:CGRectMake(kDeviceWidth * 4 + 5, 0, kDeviceWidth - 10, self.scrollViewAll.frame.size.height - 115)];
    [self.patrolRecordView setAllowPatrolRecordView:self.Id];
    self.patrolRecordView.view = self;
    [self.scrollViewAll addSubview:self.patrolRecordView];
    
    ParkEnterprisesDetailBottomView *parkEnterprisesDetailBottomViewTable = [[NSBundle mainBundle] loadNibNamed:@"ParkEnterprisesDetailBottomView" owner:nil options:nil][0];
    parkEnterprisesDetailBottomViewTable.frame = CGRectMake(kDeviceWidth * 4 + 5, self.patrolRecordView.frame.origin.y + self.patrolRecordView.frame.size.height, kDeviceWidth - 10, 100);
    parkEnterprisesDetailBottomViewTable.backgroundColor = [UIColor whiteColor];
    [parkEnterprisesDetailBottomViewTable.allAddPatrolBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    parkEnterprisesDetailBottomViewTable.timeLabel.text = [NSString stringWithFormat:@"企业环保档案最近更新于  %@", [[NSString stringWithFormat:@"%@", dic[@"lastUpdateTime"]] timeToyyyyMMddHHmmssString]];
    [self.scrollViewAll addSubview:parkEnterprisesDetailBottomViewTable];
}


- (void)setReload:(NSString *)str dic:(NSDictionary *)dic{
   if ([str isEqualToString:@"reloadBasic"]) {
        NSString *str = [NSString stringWithFormat:@"%@", dic[@"situation"]];
        NSDictionary *dicBasic = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGRect rectBasic = [str boundingRectWithSize:CGSizeMake(kDeviceWidth - 110, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicBasic context:nil];
        self.basicScrollView.contentSize = CGSizeMake(0, 615 + rectBasic.size.height);
        self.basicInformationDetailView.frame = CGRectMake(5, 0, kDeviceWidth - 10, 615 + rectBasic.size.height);
        [self.basicInformationDetailView setAllowBasicInformationDetailView:dic];
    } else if ([str isEqualToString:@"reloadEia"]) {
        [self.eiaInformationDetailView setAllowEiaInformationDetailView:dic];
    } else if ([str isEqualToString:@"reloadSewage"]) {
         [self.pollutionDetailView removeFromSuperview];
        self.pollutionDetailView = [[PollutionDetailView alloc] initWithFrame:CGRectMake(kDeviceWidth * 3 + 5, 0, kDeviceWidth - 10, self.scrollViewAll.frame.size.height - 115)];
        self.pollutionDetailView.backgroundColor = BackgroundBlack;
        [self.pollutionDetailView setAllowPollutionDetailView:dic];
        [self.scrollViewAll addSubview:self.pollutionDetailView];
    } else if ([str isEqualToString:@"reloadImage"]) {
        [self.imageInformationView setUpdateImageInformationView:dic];
    }
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
