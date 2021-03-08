//
//  PatrolResultViewController.m
//  eia
//
//  Created by JimmyYue on 2020/7/8.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "PatrolResultViewController.h"

@interface PatrolResultViewController ()

@end

@implementation PatrolResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"巡查结果情况统计";
    self.view.backgroundColor = BackgroundBlack;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, kDeviceWidth - 10, kDeviceHeight - StatusRect - NavRect)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    [self setQueryByTownparkNet];
}


//  设置表上有几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

//  每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.tableHeadListF.count > 0) {
            return self.reportEntityListF.count + 1;
        } else {
            return self.reportEntityListF.count;
        }
    } else {
        if (self.tableHeadListS.count > 0) {
            return self.reportEntityListS.count + 1;
        } else {
            return self.reportEntityListS.count;
        }
    }
}

//  分区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 110;
    }
    return 60;
}

//  设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewHeader = [[UIView alloc] init];
    if (section == 0) {
        viewHeader.backgroundColor = [UIColor whiteColor];
        InspectTheProgressHeaderView *inspectTheProgressHeaderView = [[NSBundle mainBundle] loadNibNamed:@"InspectTheProgressHeaderView" owner:nil options:nil][0];
        inspectTheProgressHeaderView.frame = CGRectMake(0, 5, kDeviceWidth - 10, 100);
        [viewHeader addSubview:inspectTheProgressHeaderView];
        
        inspectTheProgressHeaderView.titleLabel.text = @"按园区统计";
        
        [inspectTheProgressHeaderView.starTimeBtn addTarget:self action:@selector(starTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
        if ([IsBlankString isBlankString:self.createTimeStart] == NO) {
            [inspectTheProgressHeaderView.starTimeBtn setTitle:self.createTimeStart forState:UIControlStateNormal];
        }
        [inspectTheProgressHeaderView.endTimeBtn addTarget:self action:@selector(endTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
        if ([IsBlankString isBlankString:self.createTimeEnd] == NO) {
            [inspectTheProgressHeaderView.endTimeBtn setTitle:self.createTimeEnd forState:UIControlStateNormal];
        }
    } else {
        viewHeader.backgroundColor = BackgroundBlack;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kDeviceWidth - 10, 50)];
        if ([IsBlankString isBlankString:self.secondTitle] == NO) {
            label.text =  [NSString stringWithFormat:@"    %@", self.secondTitle];
        }
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = TabbarBlack_S;
        label.backgroundColor = [UIColor whiteColor];
        [viewHeader addSubview:label];
        
    }
    
    return viewHeader;
}

- (void)starTimeBtn:(UIButton *)button {
    [self setChooseTimeButton:button index:@"star"];
}

- (void)endTimeBtn:(UIButton *)button {
    [self setChooseTimeButton:button index:@"end"];
}

- (void)setChooseTimeButton:(UIButton *)button index:(NSString *)str {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        if ([str isEqualToString:@"star"]) {
            self.createTimeStart = date;
        } else if ([str isEqualToString:@"end"]) {
            self.createTimeEnd = date;
        }
        [self setQueryByTownparkNet];
        [button setTitle:date forState:UIControlStateNormal];
    }];
    datepicker.doneButtonColor = TabbarBlack_S;
    datepicker.dateLabelColor = TabbarBlack_S;
    datepicker.minLimitDate = [NSDate date:@"2020-01-01" WithFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    datepicker.maxLimitDate = [NSDate date:dateTime WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}

//  去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight;
  
    sectionHeaderHeight = 100;

    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        static NSString *str = @"DataType1TableViewCell";
         DataType1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
         if(!cell){
             cell = [[[NSBundle mainBundle]loadNibNamed:@"DataType1TableViewCell" owner:self options:nil]objectAtIndex:0];
         }
        
        if (indexPath.row == 0) {
            cell.showName.textColor = TabbarBlack_S;
            cell.divideMete.textColor = TabbarBlack_S;
            cell.finishFollow.textColor = TabbarBlack_S;
            cell.notFollow.textColor = TabbarBlack_S;
        }
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[0][@"label"]];
                cell.divideMete.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[1][@"label"]];
                cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[2][@"label"]];
                cell.notFollow.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[3][@"label"]];
            } else {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"showName"]];
                cell.divideMete.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"normal"]];
                cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"commonEdit"]];
                cell.notFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"focusEdit"]];
            }
        } else {
            if (indexPath.row == 0) {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[0][@"label"]];
                cell.divideMete.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[1][@"label"]];
                cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[2][@"label"]];
                cell.notFollow.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[3][@"label"]];
            } else {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"showName"]];
                cell.divideMete.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"normal"]];
                cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"commonEdit"]];
                cell.notFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"focusEdit"]];
            }
        }
         
         //  取消cell选中效果
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
    } else {
        static NSString *str = @"DataType2TableViewCell";
        DataType2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DataType2TableViewCell" owner:self options:nil]objectAtIndex:0];
        }
        
        if (indexPath.section == 0) {
            cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row -1][@"showName"]];
            cell.divideMete.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row -1][@"normal"]];
            cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row -1][@"commonEdit"]];
            cell.notFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row -1][@"focusEdit"]];
        } else {
            cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row -1][@"showName"]];
            cell.divideMete.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row -1][@"normal"]];
            cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row -1][@"commonEdit"]];
            cell.notFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row -1][@"focusEdit"]];
        }
        
        //  取消cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    if (indexPath.section == 0) {
        if (indexPath.row != 0) {
            [self setQueryByEtpNet:[NSString stringWithFormat:@"%@", self.reportEntityListF[indexPath.row - 1][@"showToParkId"]]];
            self.secondTitle = [NSString stringWithFormat:@"%@", self.reportEntityListF[indexPath.row - 1][@"showName"]];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)setQueryByTownparkNet {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"加载中...";
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([IsBlankString isBlankString:self.createTimeStart] == NO) {
        [dic setObject:self.createTimeStart  forKey:@"createTimeStart"];
    }
    if ([IsBlankString isBlankString:self.createTimeEnd] == NO) {
        [dic setObject:self.createTimeEnd  forKey:@"createTimeEnd"];
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"followResultRate/queryByTownpark") parameters:dic view:self completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.reportEntityListF = [NSMutableArray array];
            self.tableHeadListF = [NSMutableArray array];
            self.reportEntityListF = result[@"result"][@"reportEntityList"];
            self.tableHeadListF = result[@"result"][@"tableHeadList"];
            if (self.reportEntityListF.count > 0) {
                 [self setQueryByEtpNet:[NSString stringWithFormat:@"%@", self.reportEntityListF[0][@"showToParkId"]]];
                self.secondTitle = [NSString stringWithFormat:@"%@", self.reportEntityListF[0][@"showName"]];
            } else {
                self.reportEntityListS = [NSMutableArray array];
                self.tableHeadListS = [NSMutableArray array];
                [self.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)setQueryByEtpNet:(NSString *)showToParkId {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([IsBlankString isBlankString:self.createTimeStart] == NO) {
        [dic setObject:self.createTimeStart  forKey:@"createTimeStart"];
    }
    if ([IsBlankString isBlankString:self.createTimeEnd] == NO) {
        [dic setObject:self.createTimeEnd  forKey:@"createTimeEnd"];
    }
    if ([IsBlankString isBlankString:showToParkId] == NO) {
        [dic setObject:@{@"showToParkId":showToParkId}  forKey:@"entity"];
    }
    
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"followResultRate/queryByEtp") parameters:dic view:self completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.reportEntityListS = result[@"result"][@"reportEntityList"];
            self.tableHeadListS = result[@"result"][@"tableHeadList"];
            [self.tableView reloadData];
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
