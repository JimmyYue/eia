//
//  ChooseSewageViewController.m
//  eia
//
//  Created by JimmyYue on 2020/7/1.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "ChooseSewageViewController.h"

@interface ChooseSewageViewController ()

@end

@implementation ChooseSewageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.titleStr;
    self.view.backgroundColor = BackgroundBlack;
    
    self.searchText = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, kDeviceWidth - 30, 40)];
    self.searchText.textColor = [UIColor blackColor];
    self.searchText.font = [UIFont systemFontOfSize:15];
    self.searchText.backgroundColor = [UIColor whiteColor];
    [self.searchText.layer setMasksToBounds:YES];
    self.searchText.placeholder = @"输入关键词进行快速检索";
    _searchText.returnKeyType = UIReturnKeySearch; //变为搜索按钮
    [self.searchText.layer setCornerRadius:20.0];
    self.searchText.layer.borderWidth = 1;
    self.searchText.layer.borderColor = TabbarBlack_S.CGColor;
    [self.view addSubview:self.searchText];
    UIView *serviceChargeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    self.searchText.leftView = serviceChargeView;
    self.searchText.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imageViewSearch = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    imageViewSearch.image = IMAGENAMED(@"search");
    [self.searchText addSubview:imageViewSearch];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 40, 40);
    [btn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.arrayResult = [[NSMutableArray alloc] init];
    self.arrayChoose = [[NSMutableArray alloc] init];

    if (self.arraySelected.count > 0) {
        self.arrayChoose = [NSMutableArray arrayWithArray:self.arraySelected];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kDeviceWidth, kDeviceHeight - StatusRect - NavRect - 140)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackgroundBlack;
    [self.view addSubview:self.tableView];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(30, self.tableView.frame.origin.y + self.tableView.frame.size.height + 20, kDeviceWidth - 60, 50);
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn.layer setCornerRadius:8.0];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.backgroundColor = TabbarBlack_S;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sureBtn];
    
    [self setNetList:self.titleStr];
}

- (void)searchBtnAction {
    [self setNetList:self.titleStr];
}

- (void)sureBtnAction {
    if (self.arrayChoose.count > 0) {
        self.block(self.arrayChoose);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [SVProgressHUD showInfoWithStatus:@"请选择污染物 !"];
    }
}

//  每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayResult.count;
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *str = @"ChooseSewageTableViewCell";
    ChooseSewageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ChooseSewageTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    if ([self.titleStr isEqualToString:@"大气污染物名录"]) {
        NSString *content;
        NSString *title;
        NSString *type;
        content = [NSString stringWithFormat:@"%@   %@", self.arrayResult[indexPath.row][@"gasText"] , self.arrayResult[indexPath.row][@"casMark"]];
        title = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"gasText"]];
        type = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"casMark"]];
        
        NSMutableAttributedString *strT = [[NSMutableAttributedString alloc] initWithString:content];
        NSRange range1 = [[strT string] rangeOfString:title];
        [strT addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        
        NSRange range2 = [[strT string] rangeOfString:type];
        [strT addAttribute:NSForegroundColorAttributeName value:ZitiColor range:range2];
        [strT addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range2];
        
        cell.contentLabel.attributedText = strT;
        
        for (WasteGas *wasteGas in self.arrayChoose) {
            if ([[NSString stringWithFormat:@"%@", wasteGas.gasBelong] isEqualToString:title]) {
                cell.chooseImageBtn.selected = YES;
            }
        }
        
    } else {
        cell.contentLabel.text = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"waterText"]];
        
        for (WasteWater *wasteWater in self.arrayChoose) {
            if ([[NSString stringWithFormat:@"%@", wasteWater.waterBelong] isEqualToString:cell.contentLabel.text]) {
                cell.chooseImageBtn.selected = YES;
            }
        }
    }
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    
    ChooseSewageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.chooseImageBtn.selected == NO) {
        cell.chooseImageBtn.selected = YES;
      
        if ([self.titleStr isEqualToString:@"大气污染物名录"]) {
            WasteGas *wasteGas = [[WasteGas alloc] init];
            wasteGas.gasBelong = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"gasText"]];
            [self.arrayChoose addObject:wasteGas];
        } else {
            WasteWater *wasteWater = [[WasteWater alloc] init];
            wasteWater.waterBelong = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"waterText"]];
            [self.arrayChoose addObject:wasteWater];
        }
        
    } else {
        cell.chooseImageBtn.selected = NO;

        if ([self.titleStr isEqualToString:@"大气污染物名录"]) {
            for (WasteGas *wasteGas in self.arrayChoose) {
                if ([[NSString stringWithFormat:@"%@", wasteGas.gasBelong] isEqualToString:self.arrayResult[indexPath.row][@"gasText"]]) {
                    [self.arrayChoose removeObject:wasteGas];
                    break;
                }
            }
        } else {
            for (WasteWater *wasteWater in self.arrayChoose) {
                if ([[NSString stringWithFormat:@"%@", wasteWater.waterBelong] isEqualToString:self.arrayResult[indexPath.row][@"waterText"]]) {
                    [self.arrayChoose removeObject:wasteWater];
                    break;
                }
            }
            
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 50;
}

- (void)setNetList:(NSString *)str {
    
    NSString *url;
    if ([str isEqualToString:@"大气污染物名录"]) {
        url = @"gasBasis/query";
    } else {
        url = @"waterBasis/query";
    }
    
    NSDictionary *dic;
    if ([IsBlankString isBlankString:self.searchText.text] == NO) {
        dic = @{@"start":@"0", @"pageSize":@"1000", @"keyword":self.searchText.text, @"entity":@{}};
    } else {
        dic = @{@"start":@"0", @"pageSize":@"1000", @"entity":@{}};
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(url) parameters:dic view:nil completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            if ([result[@"result"][@"dataSizeOfCurrentPage"] integerValue] > 0) {
                
                self.arrayResult = result[@"result"][@"data"];
                [self.tableView reloadData];
            }
            
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
