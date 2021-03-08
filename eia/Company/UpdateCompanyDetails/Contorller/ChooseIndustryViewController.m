//
//  ChooseIndustryViewController.m
//  eia
//
//  Created by JimmyYue on 2020/6/30.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "ChooseIndustryViewController.h"

@interface ChooseIndustryViewController ()

@end

@implementation ChooseIndustryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.titleStr;
    self.view.backgroundColor = BackgroundBlack;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 1, kDeviceWidth - 10, kDeviceHeight - NavRect - StatusRect - 90)];
    scrollView.backgroundColor = BackgroundBlack;
    scrollView.contentSize = CGSizeMake(0, 770);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    self.industryClassificationView = [[NSBundle mainBundle] loadNibNamed:@"IndustryClassificationView" owner:nil options:nil][0];
    self.industryClassificationView.frame = CGRectMake(0, 0, kDeviceWidth - 10, 770);
    self.industryClassificationView.backgroundColor = [UIColor whiteColor];
    [self.industryClassificationView setAllowIndustryClassificationView];
    [scrollView addSubview:self.industryClassificationView];
    
    [self.industryClassificationView.levelFBtn addTarget:self action:@selector(levelFBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.industryClassificationView.levelSBtn addTarget:self action:@selector(levelSBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.titleStr isEqualToString:@"选择行业分类"]) {
        UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        updateBtn.frame = CGRectMake(30, scrollView.frame.origin.y + scrollView.frame.size.height + 20, kDeviceWidth - 60, 50);
        [updateBtn addTarget:self action:@selector(updateBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [updateBtn.layer setCornerRadius:8.0];
        [updateBtn setTitle:@"确定" forState:UIControlStateNormal];
        updateBtn.backgroundColor = TabbarBlack_S;
        [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        updateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:updateBtn];
    } else {
        scrollView.frame = CGRectMake(5, 1, kDeviceWidth - 10, kDeviceHeight - NavRect - StatusRect);
        [self.view addSubview:scrollView];
        self.industryClassificationView.reportText.userInteractionEnabled = NO;
        self.industryClassificationView.reportSText.userInteractionEnabled = NO;
        self.industryClassificationView.registrationText.userInteractionEnabled = NO;
        self.industryClassificationView.sensitiveText.userInteractionEnabled = NO;
    }
    
    
    [self setNetOne];
    
}

- (void)levelFBtnAction {
    if (self.arrayF.count > 0) {
        ChooseIndustryClassificationView *chooseVC = [[ChooseIndustryClassificationView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        chooseVC.view = self.view;
        [chooseVC setAllowChooseIndustryClassificationViewFrame:CGRectMake(100, NavRect + StatusRect + 55, kDeviceWidth - 115, kDeviceHeight - NavRect - StatusRect - 130) array:self.arrayF];
        [chooseVC setBlock:^(NSDictionary * _Nonnull dic) {
            self.industryClassificationView.levelFText.text = [NSString stringWithFormat:@"%@", dic[@"industryName"]];
            self.industryClassificationView.levelSText.text = @"";
            self.industryClassificationView.reportText.text = @"";
            self.industryClassificationView.reportSText.text = @"";
            self.industryClassificationView.registrationText.text = @"";
            self.industryClassificationView.sensitiveText.text = @"";
            [self setNetTwo:[NSString stringWithFormat:@"%@", dic[@"id"]]];
        }];
        [self.view addSubview:chooseVC];
    }
}

- (void)levelSBtnAction {
    if (self.arrayS.count > 0) {
        ChooseIndustryClassificationView *chooseVC = [[ChooseIndustryClassificationView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        chooseVC.view = self.view;
        [chooseVC setAllowChooseIndustryClassificationViewFrame:CGRectMake(100, NavRect + StatusRect + 123, kDeviceWidth - 125, kDeviceHeight - NavRect - StatusRect - 185) array:self.arrayS];
        [chooseVC setBlock:^(NSDictionary * _Nonnull dic) {
            self.industryClassificationView.levelSText.text = [NSString stringWithFormat:@"%@", dic[@"industryName"]];
            self.industryClassificationView.reportText.text = [NSString stringWithFormat:@"%@", dic[@"reportBook"]];
            self.industryClassificationView.reportSText.text = [NSString stringWithFormat:@"%@", dic[@"reportTable"]];
            self.industryClassificationView.registrationText.text = [NSString stringWithFormat:@"%@", dic[@"registerTable"]];
            self.industryClassificationView.sensitiveText.text = [NSString stringWithFormat:@"%@", dic[@"meanText"]];
        }];
        [self.view addSubview:chooseVC];
    } else {
        [SVProgressHUD showInfoWithStatus:@"请选择一级分类后选择二级分类 !"];
    }
}


- (void)updateBtnAction {
    if ([IsBlankString isBlankString:self.industryClassificationView.levelSText.text] == NO) {
        self.block(self.industryClassificationView.levelSText.text);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [SVProgressHUD showInfoWithStatus:@"请选择二级分类 !"];
    }
}

- (void)setNetOne {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"industryBasis/query") parameters:@{@"start":@"0", @"pageSize":@"1000", @"entity":@{@"kind":@"one"}} view:nil completion:^(id result) {
        
        NSLog(@"%@", result);
        
        if ([result[@"isSuccess"] intValue] == 1) {
            self.arrayF = [NSMutableArray arrayWithArray:result[@"result"][@"data"]];
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setNetTwo:(NSString *)parentId {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"industryBasis/query") parameters:@{@"start":@"0", @"pageSize":@"1000", @"entity":@{@"kind":@"two", @"parentId":parentId}} view:nil completion:^(id result) {
        
        NSLog(@"%@", result);
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.arrayS = [NSMutableArray arrayWithArray:result[@"result"][@"data"]];
            
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
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
