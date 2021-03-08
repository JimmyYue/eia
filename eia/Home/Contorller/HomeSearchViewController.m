//
//  HomeSearchViewController.m
//  eia
//
//  Created by JimmyYue on 2020/4/21.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "HomeSearchViewController.h"

@interface HomeSearchViewController ()

@end

@implementation HomeSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BackgroundBlack;
    
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, StatusRect + 60)];
    nav.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nav];
    
    self.searchText = [[UITextField alloc]initWithFrame:CGRectMake(10, StatusRect + 10, kDeviceWidth - 80, 40)];
    self.searchText.textColor = [UIColor blackColor];
    self.searchText.font = [UIFont systemFontOfSize:15];
    self.searchText.backgroundColor = [UIColor whiteColor];
    [self.searchText.layer setMasksToBounds:YES];
    self.searchText.delegate = self;
    self.searchText.placeholder = @"输入企业名称可快速查询";
    _searchText.returnKeyType = UIReturnKeySearch; //变为搜索按钮
    [self.searchText.layer setCornerRadius:20.0];
    self.searchText.layer.borderWidth = 1;
    self.searchText.layer.borderColor = TabbarBlack_S.CGColor;
    [nav addSubview:self.searchText];
    UIView *serviceChargeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    self.searchText.leftView = serviceChargeView;
    self.searchText.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 5, 30, 30);
    [btn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:IMAGENAMED(@"search") forState:UIControlStateNormal];
    [self.searchText addSubview:btn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(self.searchText.frame.origin.x + self.searchText.frame.size.width + 10,  self.searchText.frame.origin.y, 50, 40);
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nav addSubview:cancelBtn];
    
    float y;
    if (![self.type isEqualToString:@"chooseCompany"]) {
        
        UIView *addView = [[UIView alloc] initWithFrame:CGRectMake(10, StatusRect + 75, kDeviceWidth - 20, 50)];
        addView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:addView];
        
        UILabel *noLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 200, 20)];
        noLabel.text = @"没有找到对应的园区？";
        noLabel.font = [UIFont systemFontOfSize:15];
        [addView addSubview:noLabel];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(kDeviceWidth - 120, 7.5, 90, 35);
        [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [addBtn.layer setCornerRadius:8.0];
        [addBtn setTitle:@"点我新增" forState:UIControlStateNormal];
        addBtn.backgroundColor = TabbarBlack_S;
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [addView addSubview:addBtn];
        
        if ([self.type isEqualToString:@"home"]) {
            UILabel *hintLabelF = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusRect + NavRect + 100, kDeviceWidth, 20)];
            hintLabelF.text = @"搜索指定内容";
            hintLabelF.textAlignment = NSTextAlignmentCenter;
            hintLabelF.textColor = ZitiColor;
            hintLabelF.font = [UIFont systemFontOfSize:15];
            [self.view addSubview:hintLabelF];
            
            UILabel *hintLabelS = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusRect + NavRect + 120, kDeviceWidth, 20)];
            hintLabelS.text = @"企业工商登记名称                   政府规划的产业园";
            hintLabelS.textAlignment = NSTextAlignmentCenter;
            hintLabelS.textColor = ZitiColor;
            hintLabelS.font = [UIFont systemFontOfSize:15];
            [self.view addSubview:hintLabelS];
        }
        
        y = nav.frame.origin.y + nav.frame.size.height + 70;
    } else {
         y = nav.frame.origin.y + nav.frame.size.height;
    }
    
    self.arrayListResult = [[NSMutableArray alloc] init];
    if ([self.type isEqualToString:@"home"]) {
        [self.arrayListResult addObject:@{}];
        [self.arrayListResult addObject:@{}];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, kDeviceWidth, kDeviceHeight - y)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchBtnAction];
    return YES;
}

- (void)searchBtnAction {
    if ([IsBlankString isBlankString:self.searchText.text] == NO) {
        [self.view endEditing:YES];
        [self setNetSearch];
    } else {
        [SVProgressHUD showInfoWithStatus:@"请输入查询信息！"];
    }
}

- (void)cancelBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBtnAction {
    NewParkViewController *parkVC = [[NewParkViewController alloc] init];
    parkVC.type = self.type;
    [self.navigationController pushViewController:parkVC animated:YES];
}

//  设置表上有几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.type isEqualToString:@"home"]) {
        return 2;
    } else {
        return self.arrayListResult.count;
    }
}

//  每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.type isEqualToString:@"home"]) {
        return [self.arrayListResult[section] count];
    } else {
        return 1;
    }
}

//  分区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.type isEqualToString:@"home"]) {
        if (section == 0) {
            return 15;
        }
        return 45;
    } else {
        return 10;
    }
}

//  设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewHeader = [[UIView alloc] init];
    if ([self.type isEqualToString:@"home"]) {
        if (section == 0) {
            viewHeader.backgroundColor = BackgroundBlack;
        } else {
            viewHeader.backgroundColor = [UIColor whiteColor];
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth - 20, 30)];
            title.text = @"企业名称";
            title.textColor = ZitiColor;
            title.font = [UIFont systemFontOfSize:14];
            [viewHeader addSubview:title];
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(10, 44, kDeviceWidth - 10, 1)];
            line.backgroundColor = BackgroundBlack;
            [viewHeader addSubview:line];
        }
    } else {
        viewHeader.backgroundColor = BackgroundBlack;
    }
    
    return viewHeader;
}

//  去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight;
    if ([self.type isEqualToString:@"home"]) {
        sectionHeaderHeight = 10;
    } else {
        sectionHeaderHeight = 45;
    }
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.type isEqualToString:@"choosePark"]) {
        static NSString *str = @"HomeSearchTableViewCell";
        HomeSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeSearchTableViewCell" owner:self options:nil]objectAtIndex:0];
        }
        
        cell.titleLabel.text = self.arrayListResult[indexPath.section][@"parkName"];
        
        if ([[self.arrayListResult[indexPath.section] allKeys] containsObject:@"provinceName"] || [IsBlankString isBlankString:self.arrayListResult[indexPath.section][@"provinceName"]] == NO) {
            if ([IsBlankString isBlankString:self.arrayListResult[indexPath.section][@"streetName"]] == NO) {
                cell.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@", self.arrayListResult[indexPath.section][@"provinceName"], self.arrayListResult[indexPath.section][@"cityName"], self.arrayListResult[indexPath.section][@"regionName"], self.arrayListResult[indexPath.section][@"streetName"]];
            } else {
                cell.addressLabel.text = [NSString stringWithFormat:@"%@%@%@", self.arrayListResult[indexPath.section][@"provinceName"], self.arrayListResult[indexPath.section][@"cityName"], self.arrayListResult[indexPath.section][@"regionName"]];
            }
        }
        
        //  取消cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if ([self.type isEqualToString:@"chooseCompany"]) {
        
        static NSString *str = @"SearchEnterpriseTableViewCell";
        SearchEnterpriseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"SearchEnterpriseTableViewCell" owner:self options:nil]objectAtIndex:0];
        }
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][@"enterpriseName"]];
        if ([IsBlankString isBlankString:self.arrayListResult[indexPath.section][@"cpyObjAddress"]] == NO) {
            cell.addressLabel.text = [NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][@"cpyObjAddress"]];
        }
        
        //  取消cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        if (indexPath.section == 0) {
            static NSString *str = @"HomeSearchTableViewCell";
            HomeSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if(!cell){
                cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeSearchTableViewCell" owner:self options:nil]objectAtIndex:0];
            }
            
            cell.titleLabel.text = self.arrayListResult[indexPath.section][indexPath.row][@"parkName"];
            
            if ([[self.arrayListResult[indexPath.section][indexPath.row] allKeys] containsObject:@"provinceName"] || [IsBlankString isBlankString:self.arrayListResult[indexPath.section][indexPath.row][@"provinceName"]] == NO) {
                if ([IsBlankString isBlankString:self.arrayListResult[indexPath.section][indexPath.row][@"streetName"]] == NO) {
                    cell.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@", self.arrayListResult[indexPath.section][indexPath.row][@"provinceName"], self.arrayListResult[indexPath.section][indexPath.row][@"cityName"], self.arrayListResult[indexPath.section][indexPath.row][@"regionName"], self.arrayListResult[indexPath.section][indexPath.row][@"streetName"]];
                } else {
                    cell.addressLabel.text = [NSString stringWithFormat:@"%@%@%@", self.arrayListResult[indexPath.section][indexPath.row][@"provinceName"], self.arrayListResult[indexPath.section][indexPath.row][@"cityName"], self.arrayListResult[indexPath.section][indexPath.row][@"regionName"]];
                }
            }
            
            //  取消cell选中效果
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
            static NSString *str = @"SearchEnterpriseTableViewCell";
            SearchEnterpriseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if(!cell){
                cell = [[[NSBundle mainBundle]loadNibNamed:@"SearchEnterpriseTableViewCell" owner:self options:nil]objectAtIndex:0];
            }
            
            cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][indexPath.row][@"enterpriseName2cp"]];
            cell.addressLabel.text = [NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][indexPath.row][@"cpyObjAddress"]];
            
            //  取消cell选中效果
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    
   if ([self.type isEqualToString:@"home"]) {
        if (indexPath.section == 0) {
            ParkDetailViewController *parkVC = [[ParkDetailViewController alloc] init];
            parkVC.parkCode = self.arrayListResult[indexPath.section][indexPath.row][@"parkCode"];
            parkVC.detailDic = self.arrayListResult[indexPath.section][indexPath.row];
            [self.navigationController pushViewController:parkVC animated:YES];
        } else {
            
        }
    } else {
        self.block(self.arrayListResult[indexPath.section]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)setNetSearch {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"加载中...";
    
    NSString *url;
    NSDictionary *dic;
    if ([self.type isEqualToString:@"chooseCompany"]) {
        url = @"enterprise/qicha2mohu";
        dic = @{@"entity":@{@"enterpriseName":self.searchText.text}};
    } else if ([self.type isEqualToString:@"choosePark"]) {
        url = @"townpark/query";
        dic = @{@"entity":@{}, @"findText":self.searchText.text, @"findRange":@"all"};
    } else if ([self.type isEqualToString:@"home"]) {
        url = @"enterprise/homeLookFor";
        dic = @{@"entity":@{}, @"findText":self.searchText.text, @"findRange":@"all"};
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(url) parameters:dic view:self completion:^(id result) {
        
//        NSLog(@"%@", result);
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
//            if ([result[@"result"][@"dataSizeOfCurrentPage"] integerValue] > 0) {
                
                self.arrayListResult = [NSMutableArray array];
                
                if ([self.type isEqualToString:@"chooseCompany"]) {
                    NSLog(@"%@", result);
                    self.arrayListResult = result[@"result"];
                } else if ([self.type isEqualToString:@"choosePark"]) {
                    self.arrayListResult = result[@"result"][@"data"];
                } else if ([self.type isEqualToString:@"home"]) {
                    [self.arrayListResult addObject:result[@"result"][@"townparkEntityList"]];
                    [self.arrayListResult addObject:result[@"result"][@"enterpriseEntityList"]];
                }
                
                [self.tableView reloadData];
//            }
            
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
