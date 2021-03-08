//
//  UpdateEiaViewController.m
//  eia
//
//  Created by JimmyYue on 2020/6/23.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "UpdateEiaViewController.h"

@interface UpdateEiaViewController ()

@end

@implementation UpdateEiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"环保信息";
    self.view.backgroundColor = BackgroundBlack;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 1, kDeviceWidth - 10, kDeviceHeight - NavRect - StatusRect - 90)];
    scrollView.backgroundColor = BackgroundBlack;
    scrollView.contentSize = CGSizeMake(0, 820);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    self.eiaInformationView = [[NSBundle mainBundle] loadNibNamed:@"EiaInformationView" owner:nil options:nil][0];
    self.eiaInformationView.frame = CGRectMake(0, 0, kDeviceWidth - 10, 820);
    self.eiaInformationView.backgroundColor = [UIColor whiteColor];
    [self.eiaInformationView setAllowEiaInformationView:self.dicDetail];
    [scrollView addSubview:self.eiaInformationView];
    
    [self.eiaInformationView.chooseClassBtn addTarget:self action:@selector(chooseClassBtnAction) forControlEvents:UIControlEventTouchUpInside];
   
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

- (void)chooseClassBtnAction {
    ChooseIndustryViewController *industryClassificationVC = [[ChooseIndustryViewController alloc] init];
    industryClassificationVC.titleStr = @"选择行业分类";
    [industryClassificationVC setBlock:^(NSString * _Nonnull industryName) {
        self.eiaInformationView.industryNameText.text = industryName;
    }];
    [self.navigationController pushViewController:industryClassificationVC animated:YES];
}

- (void)updateBtnAction {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"%@", self.dicDetail[@"id"]]  forKey:@"id"];
    
    if ([IsBlankString isBlankString:self.eiaInformationView.industryNameText.text] == NO) {
        [dic setObject:self.eiaInformationView.industryNameText.text forKey:@"industryName"];
    }
    
    if ([IsBlankString isBlankString:self.eiaInformationView.eiaSortType] == NO) {
        [dic setObject:self.eiaInformationView.eiaSortType forKey:@"eiaSortType"];
    }
    
    if ([IsBlankString isBlankString:self.eiaInformationView.eiaPaperType] == NO) {
        [dic setObject:self.eiaInformationView.eiaPaperType forKey:@"eiaPaperType"];
    }
    
    if ([IsBlankString isBlankString:self.eiaInformationView.eiaText.text] == NO) {
        [dic setObject:self.eiaInformationView.eiaText.text forKey:@"eiaPaperEssay"];
    }
    
    if ([IsBlankString isBlankString:self.eiaInformationView.checkPaperType] == NO) {
        [dic setObject:self.eiaInformationView.checkPaperType forKey:@"checkPaperType"];
    }
    
    if ([IsBlankString isBlankString:self.eiaInformationView.acceptanceText.text] == NO) {
        [dic setObject:self.eiaInformationView.acceptanceText.text forKey:@"checkPaperEssay"];
    }
    
    if ([IsBlankString isBlankString:self.eiaInformationView.solidType] == NO) {
        [dic setObject:self.eiaInformationView.solidType forKey:@"solidType"];
    }
    
    if ([IsBlankString isBlankString:self.eiaInformationView.specificationText.text] == NO) {
        [dic setObject:self.eiaInformationView.specificationText.text forKey:@"solidEssay"];
    }
    
    if ([IsBlankString isBlankString:self.eiaInformationView.dirtyNatureType] == NO) {
        [dic setObject:self.eiaInformationView.dirtyNatureType forKey:@"dirtyNatureType"];
    } // 排污性质
    
    if ([IsBlankString isBlankString:self.eiaInformationView.dirtyLicenseType] == NO) {
        [dic setObject:self.eiaInformationView.dirtyLicenseType forKey:@"dirtyLicenseType"];
    }  // 排污许可
    
    if ([IsBlankString isBlankString:self.eiaInformationView.sewageText.text] == NO) {
        [dic setObject:self.eiaInformationView.sewageText.text forKey:@"dirtyLicenseEssay"];
    }
    
    if ([IsBlankString isBlankString:self.eiaInformationView.waterLicenseType] == NO) {
        [dic setObject:self.eiaInformationView.waterLicenseType forKey:@"waterLicenseType"];
    }
    
    if ([IsBlankString isBlankString:self.eiaInformationView.drainageText.text] == NO) {
        [dic setObject:self.eiaInformationView.drainageText.text forKey:@"waterLicenseEssay"];
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
