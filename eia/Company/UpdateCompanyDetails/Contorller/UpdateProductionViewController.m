//
//  UpdateProductionViewController.m
//  eia
//
//  Created by JimmyYue on 2020/6/23.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "UpdateProductionViewController.h"

@interface UpdateProductionViewController ()

@end

@implementation UpdateProductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"生产工艺";
    self.view.backgroundColor = BackgroundBlack;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 1, kDeviceWidth - 10, kDeviceHeight - NavRect - StatusRect - 90)];
    scrollView.backgroundColor = BackgroundBlack;
    scrollView.contentSize = CGSizeMake(0, 570);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    self.craftView = [[NSBundle mainBundle] loadNibNamed:@"CraftView" owner:nil options:nil][0];
    self.craftView.frame = CGRectMake(0, 0, kDeviceWidth - 10, 570);
    self.craftView.backgroundColor = [UIColor whiteColor];
    [self.craftView setAllowCraftView];
    [scrollView addSubview:self.craftView];
    
    if ([[self.dicDetail allKeys] containsObject:@"sortExplain"]) {
        self.craftView.speciesText.text = [NSString stringWithFormat:@"%@", self.dicDetail[@"sortExplain"]];
    }
    if ([[self.dicDetail allKeys] containsObject:@"craftExplain"]) {
        self.craftView.productionText.text = [NSString stringWithFormat:@"%@", self.dicDetail[@"craftExplain"]];
    }
    if ([[self.dicDetail allKeys] containsObject:@"mainDirt"]) {
        self.craftView.riskText.text = [NSString stringWithFormat:@"%@", self.dicDetail[@"mainDirt"]];
    }
    
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

- (void)updateBtnAction  {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[NSString stringWithFormat:@"%@", self.dicDetail[@"id"]]  forKey:@"id"];
        
        if ([IsBlankString isBlankString:self.craftView.speciesText.text] == NO) {
            [dic setObject:self.craftView.speciesText.text forKey:@"sortExplain"];
        }
        
        if ([IsBlankString isBlankString:self.craftView.productionText.text] == NO) {
            [dic setObject:self.craftView.productionText.text forKey:@"craftExplain"];
        }
        
        if ([IsBlankString isBlankString:self.craftView.riskText.text] == NO) {
            [dic setObject:self.craftView.riskText.text forKey:@"mainDirt"];
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
